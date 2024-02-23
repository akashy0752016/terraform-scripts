variable "region" {
  default = null
}
variable "terraform-state-folder" {
  default = "airbus-terraform-state-folder"
}
variable "acl_value" {
  default = "private"
}
variable "sse-alg" {
  default = "AES256"
}