module "airbus_vpc" {
  source = "../../modules/vpc"
  availability_zones = ["us-east-1a", "us-east-1b"]
  environment = "airbus"
  vpc_cidr = "172.31.0.0/16"
  private_subnets_cidr = ["172.31.80.0/20", "172.31.32.0/20"]
  public_subnets_cidr = ["172.31.16.0/20", "172.31.48.0/20"]
}