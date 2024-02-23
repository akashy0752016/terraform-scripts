module "airbus_vpc" {
  source = "../../modules/vpc"
  availability_zones = ["us-east-1a", "us-east-1b"]
  environment = "airbus"
  vpc_cidr = "10.0.0.0/16"
  private_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}