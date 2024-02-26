data "terraform_remote_state" "build-arifact-bucket" {
  backend = "s3" 
  config = {
    bucket = "airbus-terraform-state"
    key = "build-arifact-bucket/terraform.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "aurora" {
    backend = "s3"
    config = {
      bucket = "airbus-terraform-state"
      key = "resources/aurora/terraform.tfstate"
      region = "us-east-1"
    }
}
data "terraform_remote_state" "airbus-file-storage" {
    backend = "s3"
    config = {
    bucket = "airbus-terraform-state"
    key = "resources/s3/terraform.tfstate"
    region = "us-east-1"
  }
}