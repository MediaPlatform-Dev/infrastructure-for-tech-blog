resource "aws_subnet" "this" {
  vpc_id            = var.vpc_id

  count             = length(var.subnet_cidr_blocks)
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone[count.index]
  
  tags = merge(
    {
      Name = "sbn-${var.tags.Project}-${var.visibility}-${count.index}"
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