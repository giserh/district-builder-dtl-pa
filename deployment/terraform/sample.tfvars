environment = "Staging"
aws_key_name = "district-builder"
vpc_cidr_block = "10.0.0.0/16"
external_access_cidr_block = "10.10.0.0/32"
vpc_private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24"]
vpc_public_subnet_cidr_blocks = ["10.0.2.0/24", "10.0.4.0/24"]
aws_availability_zones = ["us-east-1a", "us-east-1b"]
bastion_instance_type = "t2.nano"

rds_database_identifier = "dbstaging"
rds_database_name = "district_builder"
rds_database_username = "district_builder"
rds_database_password = "districtbuilderdistrictbuilder"

app_server_availability_zone = "us-east-1a"

ssl_certificate_arn = "<redacted>"

districtbuilder_web_app_password = "districtbuilderdistrictbuilder"
districtbuilder_admin_user = "admin"
districtbuilder_admin_email = "admin@example.com"
districtbuilder_admin_password = "districtbuilderdistrictbuilder"
districtbuilder_redis_password = "districtbuilderdistrictbuilder"
districtbuilder_geoserver_user = "admin"
districtbuilder_geoserver_password = "districtbuilderdistrictbuilder"