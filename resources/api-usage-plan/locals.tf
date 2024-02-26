locals {
  name-prefix = var.use-name-prefix == true ? "${var.environment}-" : ""
  tags = {
    CreatedBy = "Terraform"
  }
}