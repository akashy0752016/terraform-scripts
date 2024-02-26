data "terraform_remote_state" "api-gateway" {
  backend = "s3" 
  config = {
    bucket = "airbus-terraform-state"
    key = "resources/api-gateway/terraform.tfstate"
    region = "us-east-1"
  }
}