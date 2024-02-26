data "terraform_remote_state" "api-usage-plan" {
  backend = "s3" 
  config = {
    bucket = "airbus-terraform-state"
    key = "resources/api-usage-plan/terraform.tfstate"
    region = "us-east-1"
  }
}