provider "aws" {
  version = "~> 1.3.0"
  region  = "${var.aws_region}"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    encrypt = "true"
  }
}
