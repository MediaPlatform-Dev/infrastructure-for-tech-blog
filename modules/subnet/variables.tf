variable "vpc_id" {}

variable "visibility" {}

variable "subnet_cidr_blocks" {
    description = "Available CIDR blocks for subnets"
    type        = list(string)
}

variable "availability_zone" {}

variable "tags" {}