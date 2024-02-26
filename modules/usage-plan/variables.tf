variable "region" {
  type = string
  default = "us-east-1"
}
variable "plan_name" {
  type = string
  default = "Basic"
}
variable "description" {
  type = string
  default = ""
}
variable "rest_api_id" {
  type = string
  default = null
}
variable "deployment_stage_name" {
  type = string
  default = null
}
variable "quota_limit" {
  type = string
  default = "5000"
}
variable "quota_period" {
  type = string
  default = "MONTH"
}
variable "burst_limit" {
  type = string
  default = "200"
}
variable "steady_state_limit" {
  type = string
  default = "100"
}
variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
}
variable "quota_config" {
  type = object({
    limit = string
    offset = string
    period = string
  })
  default = null
}
variable "throttle_settings" {
  type = object({
    burst_limit = string
    rate_limit = string
  })
  default = null
}