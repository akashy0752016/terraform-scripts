terraform {
  required_version = ">= 0.12"
}

locals {
  name = "terraform-state-bucket"
  tags = {
    CreatedBy = "Terraform"
  }
}

resource "aws_s3_bucket" "terraform-state-bucket" {
   bucket = lower(var.terraform-state-folder)
   acl = var.acl_value
   logging {
     target_bucket = ""
   }
   versioning {
     enabled = true
     mfa_delete = true
   }

   server_side_encryption_configuration {
     rule {
       apply_server_side_encryption_by_default {
         sse_algorithm = var.sse-alg
       }
     }
   }
   tags = local.tags
}