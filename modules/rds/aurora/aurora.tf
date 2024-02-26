locals {
  port = coalesce(var.engine == "aurora-postgressql" ? 5432 : 3306)
  rds_security_group_id = join("", aws_security_group.this.*.id)
  is_serverless = var.engine_mode == "serverless"
  backtrack_window = (var.engine == "aurora-mysql" || var.engine == "aurora") && var.engine_mode != "serverless" ? var.backtrack_window : 0
  master_password = var.create_cluster && var.create_random_password ? random_password.this[0].result : var.master_password
  db_subnet_group_name = var.create_db_subnet_group ? aws_db_subnet_group.this[0].name : var.db_subnet_group_name
}
resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0
  name = var.db_subnet_group_name
  subnet_ids = var.subnets
  tags = var.tags
}
resource "random_password" "this" {
  count = var.create_cluster && var.create_random_password ? 1 : 0
  length = 10
  special = false
  #override_special = "_%@"
}
resource "aws_rds_cluster" "this" {
  count = var.create_cluster ? 1 : 0
  global_cluster_identifier = var.global_cluster_identifier
  enable_global_write_forwarding = var.enable_global_write_forwarding
  cluster_identifier = var.name
  replication_source_identifier = var.replication_source_identifier
  source_region = var.region
  engine = var.engine
  engine_mode = var.engine_mode
  engine_version = local.is_serverless ? null : var.engine_version
  allow_major_version_upgrade = var.allow_major_version_upgrade
  enable_http_endpoint = var.enable_http_endpoint
  kms_key_id = var.kms_key_id
  database_name = var.is_primary_cluster ? var.database_name : null
  master_username = var.is_primary_cluster ? var.master_username : null
  master_password = var.is_primary_cluster ? local.master_password : null
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = local.is_serverless ? null : var.preferred_backup_window
  preferred_maintenance_window = local.is_serverless ? null : var.preferred_maintenance_window
  port = local.port
  db_subnet_group_name = local.db_subnet_group_name
  vpc_security_group_ids = compact(concat(aws_security_group.this.*.id, var.vpc_security_group_ids))
  snapshot_identifier = var.snapshot_identifier
  storage_encrypted = var.storage_encrypted
  apply_immediately = var.apply_immediately
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name = var.allow_major_version_upgrade ? var.db_cluster_db_instance_parameter_group_name : null
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  backtrack_window = local.backtrack_window
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  
  timeouts {
    create = lookup(var.cluster_timeouts, "create", null)
    update = lookup(var.cluster_timeouts, "update", null)
    delete = lookup(var.cluster_timeouts, "delete", null)
  }

  dynamic "scaling_configuration" {
    for_each = length(keys(var.scaling_configuration)) == 0 || !local.is_serverless ? [] : [var.scaling_configuration]

    content {
       auto_pause = lookup(scaling_configuration.value, "auto_pause", null)
       max_capacity = lookup(scaling_configuration.value, "max_capacity", null)
       min_capacity = lookup(scaling_configuration.value, "min_capacity", null)
       seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
       timeout_action = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }
  dynamic "restore_to_point_in_time" {
    for_each = length(keys(var.restore_to_point_in_time)) == 0 ? [] : [var.restore_to_point_in_time]

    content {
       source_cluster_identifier = restore_to_point_in_time.value.source_cluster_identifier
       restore_type = lookup(restore_to_point_in_time.value, "restore_type", null)
       use_latest_restorable_time = lookup(restore_to_point_in_time.value, "use_latest_restorable_time", null)
       restore_to_time = lookup(restore_to_point_in_time.value, "restore_to_time", null)
    }
  }

  lifecycle {
    ignore_changes = [
        replication_source_identifier, global_cluster_identifier
    ]
    prevent_destroy = false
  }

  tags = merge(var.tags, var.cluster_tags)
}

resource "aws_security_group" "this" {
  count = var.create_cluster && var.create_security_group ? 1 : 0
  name_prefix = "${var.name}"
  vpc_id = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from RDS Aurora ${var.name}")

  tags = merge(var.tags, var.security_group_tags, {Name = var.name})
}

resource "aws_security_group_rule" "default_ingress" {
  count = var.create_cluster && var.create_security_group ? 1 : 0
  description = "From allowed SGs"
  type = "ingress"
  from_port = local.port
  to_port = local.port
  protocol = "tcp"
  source_security_group_id = aws_security_group.this[0].id
  security_group_id = local.rds_security_group_id
}

resource "aws_security_group_rule" "egress" {
  #count = var.create_cluster && var.create_security_group ? var.security_group_egress_rules  : {}
  for_each  = var.create_cluster && var.create_security_group ? var.security_group_egress_rules : {}
  type = "egress"
  from_port = lookup(each.value, "from_port", local.port)
  to_port = lookup(each.value, "to_port", local.port)
  protocol = "tcp"
  source_security_group_id = aws_security_group.this[0].id
  security_group_id = local.rds_security_group_id
}