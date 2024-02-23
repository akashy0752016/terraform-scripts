terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "airbus-terraform-state-folder"
    key = "resources/aurora/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-lock-table"
    encrypt = true
  }
}