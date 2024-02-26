locals {
  lambda_1_obj = {
    function_handler = "lambda_function.lambda_handler"
    description = "Import customer data from CSV data file from specific directory inside S3"
    function_name = "${local.name-prefix}${var.name_lambda_1}"
    extension = "zip"
    runtime = var.lambda_runtime_python
    build_number = var.build_number_lambda_1
    rtconfig = "rtconfig-lambda-1.tpl"
    rtconfig_params = {rds-arn = local.rds_arn, rds-secret-arn = local.rds_secret_arn, bucket = local.airbus-bucket-id}
    policy-arn-list = [
        "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
    ]
  }
}
module "lambda_1" {
  source = "../../modules/lambda"
  function_name = local.lambda_1_obj.function_name
  description = local.lambda_1_obj.description
  s3_bucket = local.s3-bucket
  #s3_key = format(local.s3-key, local.lambda_1_obj.function_name, local.lambda_1_obj.function_name, local.lambda_1_obj.build_number, local.lambda_1_obj.extension)
  s3_key = "lambda-python.zip"
  role_arn = module.lambda_1_role.arn
  function_handler = local.lambda_1_obj.function_handler
  runtime = local.lambda_1_obj.runtime
  environment_variables = {
    rtconf = templatefile(local.lambda_1_obj.rtconfig, local.lambda_1_obj.rtconfig_params)
  }
  create_s3_permission = true
  create_s3_lambda_notifications = true
  s3_source_arn = local.airbus-bucket-arn
  s3_bucket_id = local.airbus-bucket-id
  tags = local.tags
  s3_filter_prefix = "input/"
  depends_on = [ module.lambda_1_role ]
}
module "lambda_1_role" {
  source = "../../modules/iam/role"
  role-name = format(local.lambda-role-name, local.lambda_1_obj.function_name)
  policy-arn-list = local.lambda_1_obj.policy-arn-list
}