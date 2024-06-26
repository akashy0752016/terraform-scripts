terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "airbus-terraform-state"
    key = "build-artifact-bucket/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}