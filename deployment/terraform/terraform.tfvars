aws_key_name = "DistrictBuilder"
vpc_cidr_block = "10.0.0.0/16"
external_access_cidr_block = "66.212.12.106/32"
vpc_private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24"]
vpc_public_subnet_cidr_blocks = ["10.0.2.0/24", "10.0.4.0/24"]
aws_availability_zones = ["us-east-1a", "us-east-1b"]
bastion_instance_type = "t2.nano"