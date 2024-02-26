data "terraform_remote_state" "lambda-function" {
  backend = "s3" 
  config = {
    bucket = "airbus-terraform-state"
    key = "resources/lambda-function/terraform.tfstate"
    region = "us-east-1"
  }
}