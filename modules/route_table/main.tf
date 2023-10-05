resource "aws_route_table" "this" {
  vpc_id   = var.vpc_id
  
  count = length(var.subnet_cidr_blocks)

  tags = merge(
    {
      Name = "rtb-${var.tags.Project}-${var.visibility}-${count.index}"
      Type = "rtb"
    },
    var.tags
  )
}

resource "aws_route" "this" {
  count                  = length(var.subnet_cidr_blocks)

  route_table_id         = aws_route_table.this[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.visibility == "public" ? var.internet_gateway_id : null
  nat_gateway_id         = var.visibility == "public" ? null : var.nat_gateway_id
}

resource "aws_route_table_association" "this" {
  count          = length(var.subnet_cidr_blocks)

  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.this[count.index].id
}