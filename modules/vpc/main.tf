resource "aws_vpc" "this" {

  cidr_block = var.cidr_block
  
  tags = merge(
    {
      Name = "vpc-${var.tags.Project}"
      Type = "vpc"
    },
    var.tags
  )
}