variable "aws_region" {}
variable "rds_username" {
  default = "root"
  type    = string
}

variable "rds_password" {}
variable "rds_db_name" {}

# Env
variable "env_prefix" {
  default = "dev"
}

# VPC
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  type = string
  default = "10.0.2.0/24"
}
variable "private_subnet_cidr_2" {
  type = string
  default = "10.0.3.0/24"
}