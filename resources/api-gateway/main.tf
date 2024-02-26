module "airbus-api" {
  source = "../../modules/apigateway-open-api"
  create_rest_api = true
  api_name = "${local.name-prefix}api"
  description = "Airbus API"
  stage_name = "poc"
  create_lambda_permission = true
  lambda_functions = [data.terraform_remote_state.lambda-function.outputs.arn_lambda_2]
  tags = local.tags
  #api_key_required = var.api_key_required
  data_trace_enabled = var.data_trace_enabled
  metrics_enabled = var.metrics_enabled
  logging_level = var.logging_level
  api_template = "${file("../../swagger/airbus.yaml")}"
  api_template_vars = {
    get_lambda_arn = data.terraform_remote_state.lambda-function.outputs.arn_lambda_2
    aws_region = var.region
    lambda_identity_timeout = 29000
  }
}