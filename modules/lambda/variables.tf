variable "region" {
  type = string
  default = "us-east-1"
}
variable "function_name" {
  type = string
  default = "function-name"
}
variable "s3_bucket" {
  type = string
  default = null
}
variable "s3_key" {
  type = string
  default = null
}
variable "s3_object_version" {
  type = string
  default = null
}
variable "lambda_at_edge" {
  description = "Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function"
  type = bool
  default = false
}
variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type = number
  default = 128
}
variable "timeout" {
  default = 300
}
variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  default = false
}
variable "role_arn" {
  default = null
}
variable "tags" {
  default = {CreatedBy = "Terraform"}
}
variable "function_handler" {
  type = string
  default = "handler"
}
variable "description" {
  default = "Lambda function with dynamic attributes for name, runtime and artifacts"
}
variable "runtime" {
  default = "dynamic"
  type = string
}
variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type = map(string)
  default = {}
}
variable "reserved_concurrent_executions" {
  description = "The amount of the reserved concurrent executions for this Lambda Function. A value of 0 disables function from being triggered and -1 removed any concurrency limitations. Default to Unreserved concurrency limit -1."
  type = number
  default = -1
}
variable "tracing_mode" {
  description = "Tracing mode of the Lambda Function . Valid value can be either PassThrough or Active"
  type = string
  default = "PassThrough"
}
variable "layers" {
  description = "List of Lambda layer version ARNs (maximum of 5) to attach to your Lambda Function"
  type = list(string)
  default = null
}
variable "package_type" {
  description = "The Lambda deployment package type. Valid option: Zip or Image"
  type = string
  default = "Zip"
}
variable "architectures" {
  description = "Instruction set architecture for your Lambda Function. Valid values are [\"x86_64\"] and [\"arm64\"]"
  type = list(string)
  default = [ "x86_64" ]
}
variable "kms_key_arn" {
  description = "The ARN of KMS Key to use by your Lambda Function"
  type = string
  default = null
}
variable "create_s3_permission" {
  default = false
  type = bool
}
variable "create_s3_lambda_notifications" {
  type = bool
  default = false
}
variable "s3_source_arn" {
  type = string
  description = "The ARN of S3 bucket which needs invoke permission on lambda"
}
variable "s3_bucket_id" {
  description = "The id of S3 bucket which sends bucket event to lambda"
  default = null
}
variable "s3_filter_prefix" {
  description = "The File prefix filter in s3 bucket"
  type = string
  default = null
}
variable "s3_filter_suffix" {
  description = "The File suffix filter in s3 bucket"
  type = string
  default = ".csv"
}
variable "vpc_config" {
  description = "VPC Configuration"
  type = object({
    security_group_ids = list(string)
    subnet_ids = list(string)
    vpc_id = string
  })
  default = null
}
variable "filename" {
  description = "Filename"
  type = string
  default = null
}
variable "source_code_hash" {
  description = "Source Code hash"
  type = string
  default = null
}
variable "events" {
  description = "S3 events for which your lambda will trigger"
  type = set(string)
  default = [ "s3:ObjectCreated:*" ]
}