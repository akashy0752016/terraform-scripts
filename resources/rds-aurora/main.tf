locals {
  name-prefix = var.use-name-prefix == true ? "${var.environment}-" : ""
  tags = {
    CreatedBy = "Terraform"
  }
}

data "aws_iam_policy_document" "rds_key_policy" {
  statement {
    sid = "Allow access through RDS for all principals in the account that are authorized to use RDS"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:CreateGrant",
        "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test = "StringEquals"
      variable = "kms:ViaService"
      values = ["rds.${var.region}.amazonaws.com"]
    }
    condition {
      test = "StringEquals"
      variable = "kms:CallerAccount"
      values = ["arn:aws:iam::${var.account}:root"]
    }
  }
  statement {
    sid = "Allow direct access to key metadata to the account"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.account}:root"]
    }
    actions = [
        "kms:*"
    ]
    resources = ["*"]
  }
}
module "rds_kms_key" {
  source = "../../modules/kms"
  name = "${local.name-prefix}rds"
  policy = data.aws_iam_policy_document.rds_key_policy.json
  tags = local.tags
  enable_key_rotation = false
}
module "aurora_mysql" {
  source = "../../modules/rds/aurora"
  name = lower("${local.name-prefix}${var.name}")
  engine = var.engine
  engine_mode = var.engine_mode
  storage_encrypted = var.storage_encrypted
  database_name = var.database_name
  create_random_password = false
  enable_http_endpoint = var.enable_http_endpoint
  vpc_id = var.vpc_id
  subnets = var.subnets
  create_db_subnet_group = true
  db_subnet_group_name = var.db_subnet_group_name
  create_security_group = true
  kms_key_id = module.rds_kms_key.key_arn
  deletion_protection = true
  apply_immediately = var.apply_immediately
  skip_final_snapshot = var.skip_final_snapshot
  scaling_configuration = {
    auto_pause = true
    min_capacity = var.scaling_min_capacity
    max_capacity = var.scaling_max_capacity
    seconds_until_auto_pause = var.scaling_seconds_until_auto_pause
    timeout_action = var.scaling_timeout_action
  }
  depends_on = [ module.rds_kms_key ]
}
module "rds_secret_key" {
  source = "../../modules/secretmanager"
  kms_key = ""
  name = "${local.name-prefix}aurora-db-credentials-${module.aurora_mysql.cluster_resource_id}"
  credentials = {username = module.aurora_mysql.cluster_master_username, password = module.aurora_mysql.cluster_master_passowrd}
  tags = local.tags
  depends_on = [ module.aurora_mysql ]
}