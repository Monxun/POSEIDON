variable "region" {
    default     = "us-west-2"
    description = "AWS region"
}

variable "cluster-name" {
    default = "aline-financial-cluster-MG"
}

# AWS ACCOUNT
variable "map_accounts" {
    description = "Additional AWS account numbers to add to the aws auth-config map"
    type        = list(string)

    default = [
        "777777777777",
        "888888888888",
    ]
}

variable "map_roles" {
    description = "Additional IAM roles to add to the aws auth-config map"
    type        = list(object({
        rolearn  = string
        username = string
        groups   = list(string)
    }))

    default = [
        {
            rolearn  = "arn:aws:iam::666666666666:role:role1"
            username = "role1"
            groups   = ["system:masters"]
        },
        {
            rolearn  = "arn:aws:iam::666666666666:role:role2"
            username = "role1"
            groups   = ["system:masters"]
        },
    ]
}

variable "map_users" {
    description = "Additional IAM users to add to the aws auth-config map"
    type        = list(object({
        userarn  = string
        username = string
        groups   = list(string)
    }))

    default = [
        {
            rolearn  = "arn:aws:iam::666666666666:user:user1"
            username = "user1"
            groups   = ["system:masters"]
        },
        {
            rolearn  = "arn:aws:iam::666666666666:user:user2"
            username = "user2"
            groups   = ["system:masters"]
        },
    ]
}

