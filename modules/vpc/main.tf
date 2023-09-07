resource "aws_vpc" "this" {

  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  
  tags = merge(
    {
      Name = "vpc-${var.tags.Project}"
      Type = "vpc"
    },
    var.tags
  )
}