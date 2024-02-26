locals {
  lambda_2_obj = {
    function_handler = "lambda_function.lambda_handler"
    description = "Get processed data from RDS"
    function_name = "${local.name-prefix}${var.name_lambda_2}"
    extension = "zip"
    runtime = var.lambda_runtime_python
    build_number = var.build_number_lambda_2
    rtconfig = "rtconfig-lambda-1.tpl"
    rtconfig_params = {rds-arn = local.rds_arn, rds-secret-arn = local.rds_secret_arn, bucket = local.airbus-bucket-id}
    policy-arn-list = [
        "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
        "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator",
        "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
    ]
  }
}
module "lambda_2" {
  source = "../../modules/lambda"
  function_name = local.lambda_2_obj.function_name
  description = local.lambda_2_obj.description
  s3_bucket = local.s3-bucket
  #s3_key = format(local.s3-key, local.lambda_2_obj.function_name, local.lambda_2_obj.function_name, local.lambda_2_obj.build_number, local.lambda_2_obj.extension)
  s3_key = "lambda-python.zip"
  role_arn = module.lambda_2_role.arn
  function_handler = local.lambda_2_obj.function_handler
  runtime = local.lambda_2_obj.runtime
  environment_variables = {
    rtconf = templatefile(local.lambda_2_obj.rtconfig, local.lambda_2_obj.rtconfig_params)
  }
  tags = local.tags
  depends_on = [ module.lambda_2_role ]
}
module "lambda_2_role" {
  source = "../../modules/iam/role"
  role-name = format(local.lambda-role-name, local.lambda_2_obj.function_name)
  policy-arn-list = local.lambda_2_obj.policy-arn-list
}