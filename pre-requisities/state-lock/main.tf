locals {
  name = "terraform-state-lock"
  tags = {
    CreatedBy = "Terraform"
  }
}

resource "aws_dynamodb_table" "terraform-state-lock" {
  name = lower(var.table)
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = local.tags
  server_side_encryption {
    enabled = var.enable-server-side-encryption
  }
}