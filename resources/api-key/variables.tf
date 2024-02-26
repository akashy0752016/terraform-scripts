variable "region" {
  default = "us-east-1"
}
variable "use-name-prefix" {
  type = bool
  default = true
}
variable "environment" {
  default = "airbus"
}
variable "api_key_required" {
  type = bool
  default = true
}
variable "data_trace_enabled" {
  type = bool
  default = false
}
variable "metrics_enabled" {
  type = bool
  default = false
}
variable "logging_level" {
  default = "ERROR"
}
variable "deployment_stage_name" {
  default = "poc"
}
variable "description" {
  default = "Internal Key"
}