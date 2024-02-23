locals {
  name = "airbus-file-storage"
  tags = {
    CreatedBy = "Terraform"
  }
}
resource "aws_s3_bucket" "airbus-flat-file-storage" {
  bucket = local.name
  acl = var.acl_value
   logging {
     target_bucket = ""
   }
   versioning {
     enabled = true
     mfa_delete = false
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