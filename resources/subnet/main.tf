resource "aws_subnet" "rds_subnet" {
  vpc_id     = "vpc-0c16bd22e0d73c447"
  
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "rds_subnet1" {
  vpc_id     = "vpc-0c16bd22e0d73c447"
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-1b"
}