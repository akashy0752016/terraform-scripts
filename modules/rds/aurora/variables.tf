variable "name" {
  description = "Name used accross resources created"
  type = string
  default = ""
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
}
variable "create_cluster" {
  description = "Whether cluster should be created (affects nearly all resources)"
  type = bool
  default = true
}
variable "create_db_subnet_group" {
  description = "Whether cluster should be created (affects nearly all resources)"
  type = bool
  default = false
}
variable "is_primary_cluster" {
  description = "Determines whether cluster is primary cluster with writer instance (set to `false` for global cluster and replica cluster)"
  type = bool
  default = true
}
variable "global_cluster_identifier" {
  description = "The global cluster identifier specified on `aws_rds_global_cluster`"
  type = string
  default = null
}
variable "enable_global_write_forwarding" {
  description = "Whether cluster should forward writes to as associated global cluster. Applied to secondary cluster to enable them to forward writes to an `aws_rds_global_cluster`'s primary cluster"
  type = bool
  default = null
}
variable "replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica"
  type = string
  default = null
}
variable "region" {
  description = "The source region for an encrypted replica DB cluster"
  type = string
  default = ""
}
variable "engine" {
  description = "The name of the database engine to be used for this DB cluster. Default to `aurora`. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  type = string
  default = null
}
variable "engine_mode" {
  description = "The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Default to: `provisioned`"
  type = string
  default = null
}
variable "engine_version" {
  description = "The databse engine version. Updating the argument results in an outage"
  type = string
  default = null
}
variable "allow_major_version_upgrade" {
  description = "Enable to allow major engine version upgrades when changing engine verison is set to `serverless`"
  type = bool
  default = false
}
variable "enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to `serverless`"
  type = bool
  default = false
}
variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying `kma_key_id`, `storage_encrypted needs to be set to `true`"
  type = string
  default = null
}
variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type = string
  default = null
}
variable "master_username" {
  description = "Username for the master DB user"
  type = string
  default = "admin"
}
variable "create_random_password" {
  description = "Destermines whether to create random password for RDS primary cluster"
  type = bool
  default = true
}
variable "random_password_length" {
  description = "Length of random password to create. Defaults to `10`"
  type = number
  default = 10
}
variable "master_password" {
  description = "Password for the master DB user. Note- when specifying a value here, `create_random_password` should be set to `false`"
  type = string
  default = "admin123"
}
variable "final_snapshot_identifier" {
  description = "The name to use when creating a final snapshot on cluste destroy"
  type = string
  default = "final"
}
variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is cluster"
  type = bool
  default = null
}
variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The defauls is `false`"
  type = bool
  default = false
}
variable "backup_retention_period" {
  description = "The days to retain backup for. Default `7`"
  type = number
  default = 7
}
variable "preferred_backup_window" {
  description = "The daily time range during which automates backups are created if automated backups are enables using the `backup_retention_period` parameter. Time in UTC"
  type = string
  default = "02:00-03:00"
}
variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type = string
  default = "sun:05:00-sun:06:00"
}
variable "port" {
  description = "The port on which the DB accepts connections"
  type = string
  default = null
}
variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
  type = list(string)
  default = []
}
variable "cidr_block_list" {
  description = "List of cidr_blocks"
  type = list(string)
  default = []
}
variable "snapshot_identifier" {
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
  type = string
  default = null
}
variable "storage_encrypted" {
  description = "Specifies wheter the DB cluster is encrypted. The default is `true`"
  type = bool
  default = true
}
variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied imediately, or during the next maintenance window. Default is `false`"
  type = bool
  default = null
}
variable "db_cluster_parameter_group_name" {
  description = "A cluster parameter group to associate with the cluster"
  type = string
  default = null
}
variable "db_cluster_db_instance_parameter_group_name" {
  description = "Instance parameter group to associate with all instances of the DB cluster. The `db_cluster_db_instance_parameter_group_name` is only valid in combination with `allow_major_version_upgrade`"
  type = string
  default = null
}
variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enables"
  type = bool
  default = false
}
variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only availabe for `aurora` engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours)"
  type = number
  default = null
}
variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type = map(string)
  default = {}
}
variable "scaling_configuration" {
  description = "Map of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless`"
  type = map(string)
  default = {}
}
variable "restore_to_point_in_time" {
  description = "Map of nested attributes for cloning Aurora cluster"
  type = map(string)
  default = {}
}
variable "cluster_tags" {
  description = "A map of tags to add to only the cluster. Used for AWS Instance scheduler tagging"
  type = map(string)
  default = {}
}
variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with instances"
  type = string
  default = null
}
variable "instance_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster instance(s)"
  type = map(string)
  default = {}
}
variable "endpoints" {
  description = "Map of additional cluster endpoints and their attributes to be created"
  type = any
  default = {}
}
variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type = string
  default = null
}
variable "subnets" {
  description = "List of subnet IDs used by database subnet group created"
  type = set(string)
  default = []
}
variable "db_subnet_group_name" {
  description = "Subnet group name"
  type = string
  default = ""
}
variable "create_security_group" {
  description = "Determines wwhether to create security group for RDS Cluster"
  type = bool
  default = true
}
variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in description"
  type = string
  default = null
}
variable "security_group_tags" {
  description = "Additional tags for the security group"
  type = map(string)
  default = {}
}
variable "allowed_security_groups" {
  description = "A list of Security group id's to allow access to"
  type = list(string)
  default = []
}
variable "security_group_egress_rules" {
  description = "A map of security group egress rule definitions to add to the security group created"
  type = map(any)
  default = {}
}
variable "copy_tags_to_snapshot" {
  description = "Copy all cluster `tags` to snapshot"
  type = bool
  default = true
}
variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to export to cloudwatch. If omittes, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql`"
  type = list(string)
  default = []
}