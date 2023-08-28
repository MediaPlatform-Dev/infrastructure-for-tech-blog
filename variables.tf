# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "AWS environment"
  type        = string
}


# Network

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  type        = string
}

variable "subnet_cidr" {
  description = "List of CIDR Blocks for each Public Subnet"
  type        = map(list(string))
}


# RDS

variable "rds_config" {}

variable "sg_rds_cidr" {}

variable "sg_rds_source" {}

variable "rds_master_username" {}

variable "rds_master_password" {}