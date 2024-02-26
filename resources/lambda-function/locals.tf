locals {
  rds_arn = data.terraform_remote_state.aurora.outputs.rds_arn
  rds_secret_arn = data.terraform_remote_state.aurora.outputs.rds_secret_arn
  airbus-bucket-id = data.terraform_remote_state.airbus-file-storage.outputs.airbus-flat-file-storage-id
  airbus-bucket-arn = data.terraform_remote_state.airbus-file-storage.outputs.airbus-flat-file-storage-arn
  lambda-role-name = "%s-role"
  s3-bucket = "airbus-${var.artifact}"
  s3-key = "%s/%s-%s.%s"
  name-prefix = var.use-name-prefix == true ? "${var.environment}-" : ""
  tags = {
    CreatedBy = "Terraform"
  }
}