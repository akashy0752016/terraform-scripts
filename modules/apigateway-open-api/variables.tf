variable "region" {
  type = string
  default = "us-east-1"
}
variable "api_name" {
  type = string
  default = null
}
variable "endpoint_configuration" {
  default = ["REGIONAL"]
  type = list(string)
}
variable "stage_name" {
  type = string
  default = "dev"
}
variable "description" {
  type = string
  default = "API Gateway"
}
variable "create_rest_api" {
  type = bool
  default = true
}
variable "create_lambda_permission" {
  type = bool
  default = true
}
variable "rest_api_id" {
  type = string
  default = ""
}
variable "rest_api_root_resource_id" {
  type = string
  default = ""
}
variable "rest_api_execution_arn" {
  type = string
  default = ""
}
variable "lambda_functions" {
  type = list(string)
  default = []
}
variable "api_key_source" {
  description = "API Key source, can have HEADER and AUTHORIZER"
  type = string
  default = "HEADER"
}
variable "api_template" {
  description = "API Gateway OpenAPI 3 template file"
}
variable "api_template_vars" {
  description = "Variables reqired in the OpenAPI Template File"
  type = map
}
variable "tags" {
  default = {CreatedBy = "Terraform"}
}
variable "enable_access_log_settings" {
  type = bool
  default = false
}
variable "cloudwatch_log_group_name" {
  description = "Name of Cloudwatch logs group name to use"
  type = string
  default = ""
}
variable "cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827 and 3653."
  type = number
  default = 0
}
variable "cloudwatch_log_group_skip_destroy" {
  description = "Specifies to skip destroy"
  type = bool
  default = true
}
variable "cloudwatch_log_group_kms_key_id" {
  description = "Te ARN of the KMS Key to use when encrypting log data"
  type = string
  default = null
}
variable "cloudwatch_log_group_tags" {
  description = "A map of tags to assign to the resource."
  type = map(string)
  default = {}
}
variable "xray_tracing_enabled" {
  description = "Enable access logs for API stage by default false"
  type = bool
  default = false
}
variable "client_certificate_id" {
  description = "The identifier of a client certificate for the stage"
  type = string
  default = null
}
variable "access_log_format" {
  description = "The formatting an values recorded in the logs"
  type = string
  default = "{\"requestId\": \"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"caller\": \"$context.identity.caller\", \"user\": \"$context.identity.user\", \"requestTime\": \"$context.requestTime\", \"httpMethod\": \"$context.httpMethod\", \"resourcePath\": \"$context.resourcePath\", \"status\": \"$context.status\", \"protocol\": \"$context.protocol\", \"responseLength\": \"$context.responseLength\"}"
}
variable "metrics_enabled" {
  type = bool
  default = false
}
variable "data_trace_enabled" {
  type = bool
  default = false
}
variable "logging_level" {
  default = "ERROR"
}
variable "api_throttling_burst_limit" {
  type = number
  default = -1
}
variable "api_throttling_rate_limit" {
  type = number
  default = -1
}