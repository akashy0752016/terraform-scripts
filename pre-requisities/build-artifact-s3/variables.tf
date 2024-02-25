variable "region" {
  default = "us-east-1"
}
variable "terraform-state-folder" {
  default = "terraform-state"
}
variable "acl_value" {
  default = "private"
}
variable "sse-alg" {
  default = "AES256"
}
variable "enable-server-side-encryption" {
  type = bool
  description = "Enable Server side encryption, default value true"
  default = true
}
variable "table" {
  default = "state-lock-table"
}