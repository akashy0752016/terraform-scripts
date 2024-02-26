variable "region" {
  default = "us-east-1"
}
variable "name" {
  default = "apikey"
}
variable "enable_key" {
  default = true
}
variable "description" {
  default = ""
}
variable "usage_plan_id" {
  default = ""
}
variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
}