# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "AWS region"
  type        = string
}

# dynamodb

variable "dynamodb_name" {}

variable "dynamodb_billing_mode" {}

variable "dynamodb_read_capacity" {}

variable "dynamodb_write_capacity" {}

variable "dynamodb_hash_key" {}


# s3

variable "s3_bucket" {}


# VPC

variable "vpc_cidr_block" {}


# Subnet

variable "subnet_cidr_blocks" {}


# Security Group

variable "security_group_rules" {}


# RDS


variable "rds_engine" {}

variable "rds_engine_version" {}

variable "rds_instance_class" {}

variable "rds_db_name" {}

variable "rds_username" {}

variable "rds_password" {}


# EC2

variable "ec2_ami" {}

variable "ec2_instance_type" {}

variable "ec2_key_name" {}

variable "tags" {}