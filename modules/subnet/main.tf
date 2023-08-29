resource "aws_subnet" "this" {
  count             = length(var.subnet_cidr_blocks)

  vpc_id            = var.vpc_id
  cidr_block        = element(split("-", var.subnet_cidr_blocks[count.index]), 1)
  availability_zone = var.availability_zone
  
  tags = merge(
    {
      Name = "sbn-${var.tags.Project}-${element(split("-", var.subnet_cidr_blocks[count.index]), 0)}"
      Type = "sbn"
    },
    var.tags
  )
}

resource "aws_route_table_association" "this" {
  count          = length(var.subnet_cidr_blocks)

  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = var.route_table_ids[count.index]
}