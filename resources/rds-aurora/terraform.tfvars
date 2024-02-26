use-name-prefix = true
environment = "poc"
#vpc_id = data.terraform_remote_state.vpc.vpc_id
db_subnet_group_name = "airbus-default-db"
subnets = [ "subnet-0291c3c009ae6a52f", "subnet-02a5e7c0f06849480", "subnet-0744bfd00a7ccae86", "subnet-0fc43dc9d860ad3a4", "subnet-0dcfc99e86bbe71a2", "subnet-0c78d60b0385cfc6a" ]
account = 051723651593