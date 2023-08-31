# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "AWS region"
  type        = string
}


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

variable "rds_username" {}

variable "rds_password" {}


# EC2

variable "ec2_ami" {}

variable "ec2_instance_type" {}

variable "tags" {}