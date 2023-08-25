# VPC 생성
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-vpc"
      Type = "vpc"
    },
    var.tags
  )
}

# 추가 IPv4 CIDR block 설정
#resource "aws_vpc_ipv4_cidr_block_association" "this" {
#  for_each = var.vpc_cidr_secondary

#  vpc_id     = aws_vpc.this.id
#  cidr_block = each.value.cidr_block
#}