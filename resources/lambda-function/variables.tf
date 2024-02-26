variable "region" {
  default = "us-east-1"
}
variable "lambda_runtime_python" {
  default = "python3.9"
}
variable "artifact" {
  default = "build-artifact-bucket"
}
variable "environment" {
  default = "airbus"
}
variable "use-name-prefix" {
  type = bool
  default = true
}
variable "build_number_lambda_1" {
  default = "initial"
}
variable "name_lambda_1" {
  default = "flat-file-processor"
}
variable "build_number_lambda_2" {
  default = "initial"
}
variable "name_lambda_2" {
  default = "flat-file-api"
}

