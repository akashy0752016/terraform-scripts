terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "airbus-terraform-state-test"
    key = "resources/subnet/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-lock-table"
    encrypt = true
  }
}