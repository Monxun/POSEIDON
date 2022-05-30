resource "aws_db_instance" "aline-db" {
allocated_storage = 20
identifier = var.rds_name
storage_type = "gp2"
engine = "mysql"
engine_version = "8.0"
instance_class = "db.m4.large"
name = var.rds_name
username = var.rds_username
password = var.rds_password
parameter_group_name = "default.mysql8.0"
}