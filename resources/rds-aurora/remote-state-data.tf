data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
      bucket = "airbus-terraform-state-folder-test"
      key = "resources/vpc/terraform.tfstate"
      region = "us-east-1"
    }
}