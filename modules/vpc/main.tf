resource "aws_vpc" "this" {

  cidr_block = var.cidr_block

  enable_dns_support = true
  
  tags = merge(
    {
      Name = "vpc-${var.tags.Project}"
      Type = "vpc"
    },
    var.tags
  )
}