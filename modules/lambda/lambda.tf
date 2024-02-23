resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description = var.description
  memory_size = var.memory_size
  filename = var.filename
  source_code_hash = var.source_code_hash
  s3_bucket = var.s3_bucket
  s3_key = var.s3_key
  s3_object_version = var.s3_object_version
  role = var.role_arn
  handler = var.function_handler
  runtime = var.runtime
  timeout = var.lambda_at_edge ? min(var.timeout, 30) : var.timeout
  publish = var.lambda_at_edge ? true : var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  layers = var.layers
  kms_key_arn = var.kms_key_arn
  package_type = var.package_type
  architectures = var.architectures
  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids = vpc_config.value.subnet_ids
      vpc_id = vpc_config.value.vpc_id
    }
  }
  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
  tracing_config {
    mode = var.tracing_mode
  }
  tags = var.tags
}
#Permission update for trigger
resource "aws_lambda_permission" "s3" {
  count = var.create_s3_permission ? 1 : 0
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal = "s3.amazonaws.com"
  source_arn = var.s3_source_arn
}
resource "aws_s3_bucket_notification" "notify-lambda" {
  count = var.create_s3_lambda_notifications ? 1 : 0
  bucket = var.s3_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events = var.events
    filter_prefix = var.s3_filter_prefix
    filter_suffix = var.s3_filter_suffix
  }
}