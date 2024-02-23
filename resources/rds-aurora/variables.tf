variable "region" {
  type = string
  description = "The name of region"
  default = "us-east-1"
}
variable "name" {
  type = string
  description = "The name of database cluster"
  default = "Airbus"
}
variable "environment" {
  default = "poc"
}
variable "use-name-prefix" {
  type = bool
  description = "Controls the name prefix"
  default = true
}
variable "engine" {
  type = string
  default = "aurora-mysql"
}
variable "engine_mode" {
  type = string
  default = "serverless"
}
variable "enable_http_endpoint" {
  description = "Enables or Disable http endpoint"
  type = bool
  default = true
}
variable "storage_encrypted" {
  description = "Specifies whether the DB Cluster is encrypted"
  type = bool
  default = true
}
variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type = string
  default = "airbus"
}
variable "account" {
  
}
variable "vpc_id" {
  description = "Id of the VPC where to create security group"
  type = string
}
variable "db_subnet_group_name" {
  type = string
}
variable "subnets" {
  description = "List of subnets IDs used by database subnet group created"
  type = list(string)
  default = []
}
variable "apply_immediately" {
  type = bool
  default = true
}
variable "skip_final_snapshot" {
  type = bool
  default = true
}
variable "scaling_min_capacity" {
  type = number
  default = 2
}
variable "scaling_max_capacity" {
  type = number
  default = 64
}
variable "scaling_seconds_until_auto_pause" {
  type = number
  default = 300
}
variable "scaling_timeout_action" {
  type = string
  default = "RollbackCapacityChange"
}