locals {
  rest_api_id = var.create_rest_api ? aws_api_gateway_rest_api.this[0].id : var.rest_api_id
  rest_api_root_resource_id = var.create_rest_api ? aws_api_gateway_rest_api.this[0].root_resource_id : var.rest_api_root_resource_id
  rest_api_execution_arn = var.create_rest_api ? aws_api_gateway_rest_api.this[0].execution_arn : var.rest_api_execution_arn
}
data "template_file" "open_api_template" {
  template = var.api_template
  vars = var.api_template_vars
}
resource "aws_api_gateway_rest_api" "this" {
  count = var.create_rest_api ? 1 : 0
  name = var.api_name
  description = var.description
  api_key_source = var.api_key_source
  body = data.template_file.open_api_template.rendered
  endpoint_configuration {
    types = var.endpoint_configuration
  }
  tags = var.tags
  minimum_compression_size = 1
}
resource "aws_api_gateway_deployment" "dummy" {
  rest_api_id = local.rest_api_id
  triggers = {
    redeployment = sha1(jsondecode(aws_api_gateway_rest_api.this[0].body))
  }
}
resource "aws_cloudwatch_log_group" "this" {
  count = var.enable_access_log_settings ? 1 : 0
  name = coalesce(var.cloudwatch_log_group_name, var.api_name)
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  skip_destroy = var.cloudwatch_log_group_skip_destroy
  kms_key_id = var.cloudwatch_log_group_kms_key_id
  tags = merge(var.tags, var.cloudwatch_log_group_tags)
}
resource "aws_api_gateway_stage" "this" {
  depends_on = [ aws_api_gateway_deployment.dummy ]
  stage_name = var.stage_name
  rest_api_id = local.rest_api_id
  deployment_id = aws_api_gateway_deployment.dummy.id
  xray_tracing_enabled = var.xray_tracing_enabled
  client_certificate_id = var.client_certificate_id
  dynamic "access_log_settings" {
    for_each = var.enable_access_log_settings == true ? [1] : []
    content {
      destination_arn = aws_cloudwatch_log_group.this[0].arn
      format = var.access_log_format
    }
  }
}
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = local.rest_api_id
  stage_name = aws_api_gateway_stage.this.stage_name
  triggers = {
    redeployment = sha1(jsondecode(aws_api_gateway_rest_api.this[0].body))
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_lambda_permission" "this" {
  depends_on = [ aws_api_gateway_stage.this ]
  count = var.create_lambda_permission && length(var.lambda_functions) > 0 ? length(var.lambda_functions) : 0
  statement_id = "AllowExecutionFromApiGateway-OpenAPI"
  action = "lambda:InvokeFunction"
  function_name = element(var.lambda_functions, count.index)
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.rest_api_execution_arn}/${aws_api_gateway_stage.this.stage_name}/*"
}
resource "aws_api_gateway_method_settings" "this" {
  depends_on = [ aws_api_gateway_deployment.this ]
  rest_api_id = local.rest_api_id
  stage_name = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    # Enable cloudwatch logiing and metrics
    metrics_enabled = var.metrics_enabled
    data_trace_enabled = var.data_trace_enabled
    logging_level = var.logging_level

    # Limit the rate of call to prevent abuse and unwanted charges
    throttling_burst_limit = var.api_throttling_burst_limit
    throttling_rate_limit = var.api_throttling_rate_limit
  }
}