resource "aws_nat_gateway" "this" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id
  
  tags = merge(
    {
      Name = "nat-${var.tags.Project}"
      Type = "nat"
    },
    var.tags
  )
}