variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "environment" {
  type = string
  default = ""
}
variable "public_subnets_cidr" {
  type = list(string)
  default = []
}
variable "availability_zones" {
  type = list(string)
  default = []
}
variable "private_subnets_cidr" {
  type = list(string)
  default = []
}