variable "region" {
    default     = "us-west-2"
    description = "AWS region"
}

# S3
variable "bucket_name" {
    default     = "project-bucket"
    description = "S3 Bucket Name"
}

variable "acl_value" {
    default     = "private"
    description = "Type of Bucket"
}

# RDS
variable "rds_name" {
    default     = "aline-db-mg"
    description = "RDS Name"
}

variable "rds_username" {
    default     = "admin"
    description = "RDS Username"
}

variable "rds_password" {
    default     = "Admin@54132"
    description = "RDS Password"
}