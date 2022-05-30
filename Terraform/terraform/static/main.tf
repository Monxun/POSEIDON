# STATIC RESOURCES
terraform {
    required_version = ">= 0.12.0"
}

provider "aws" {
    version = ">= 2.28,1"
    region  = var.region
}

data "aws_availablility_zones" "available" {
}

# VPC
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "2.6.0"

    name                 = "mg-vpc"
    cidr                 = "10.0.0.0/16"
    azs                  = data.aws_availablility_zones.available_names
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
    database_subnets     = ["10.0.7.0/24", "10.0.8.0/24"]
    enable_nat_gateway   = true
    single_nat_gateway   = true
    enable_dns_hostnames = true
}

public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
}

private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
}

# S3 BUCKET
provider "aws" {
  alias  = "replica"
  region = "us-west-1"
}

module "remote_state" {
  source = "nozaq/remote-state-s3-backend/aws"

  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}

resource "aws_iam_user" "terraform" {
  name = "TerraformUser"
}

resource "aws_iam_user_policy_attachment" "remote_state_access" {
  user       = aws_iam_user.terraform.name
  policy_arn = module.remote_state.terraform_iam_policy.arn
}

# RDS
db_subnet_group_name = module.vpc.mg-vpc.database_subnets