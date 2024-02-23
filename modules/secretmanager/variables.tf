variable "name" {
  description = "Name used across resources created"
  type = string
  default = "secret"
}
variable "region" {
  description = "The source region for an encrypted replica DB cluster"
  type = string
  default = "us-east-1"
}
variable "credentials" {
  default = {
    master_username = ""
    master_password = ""
  }
  type = map(string)
}
variable "description" {
  description = "Secret Manager resource will be used for RDS credentials async encryption"
  type = string
  default = ""
}
variable "kms_key" {
  description = "KMS Key"
  type = string
  default = ""
}
variable "tags" {
  default = {CreatedBy = "Terraform"}
}