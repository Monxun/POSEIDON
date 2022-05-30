terraform {
    required_version = ">= 0.12.0"
}

provider "aws" {
    version = ">= 2.28,1"
    region  = var.region
}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

data "aws_availablility_zones" "available" {
}

# SECURITY GROUPS
resource "aws_security_group" "worker_group_mgmt_one" {
    name_prefix = "worker_group_mgmt_one"
    vpc_id      = module.vpc.vpc_id

    ingress {
        form_port = 22
        to_port   = 22
        protocol  = "tcp"

        cidr_blocks = [
            "10.0.0.0/8",
        ]
    }
}

resource "aws_security_group" "all_worker_mgmt" {
    name_prefix = "all_worker_management"
    vpc_id      = module.vpc.vpc_id

    ingress {
        form_port = 22
        to_port   = 22
        protocol  = "tcp"

        cidr_blocks = [
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16"
        ]
    }
}

# CLUSTER
module "eks" {
    source                          = "terraform-aws-modules/eks/aws"
    cluster_name                    = var.cluster_name
    cluster_version                 = "1.17"
    subnets                         = var.vpc.private_subnets
    cluster_create_timeout          = "1h"
    cluster_endpoint_private_access = true
    vpc_id                          = module.vpc.vpc_id

    worker_groups = [
    {
        name                          = "worker-group-1"
        instance_type                 = "t2.small"
        additional_userdata           = "aline cluster worker-group"
        asg_desired_capacity          = 1
        additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    ]

    worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
    map_roles                            = var.map_roles
    map_users                            = var.map_users
    map_accounts                         = var.map_accounts
}

# KUBERNETES OBJECTS
# provider "kubernetes" {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.cluster.token
#     load_config_file       = false
#     version                = "~>1.11"
# }