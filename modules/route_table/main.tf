resource "aws_route_table" "this" {
  vpc_id   = var.vpc_id
  
  for_each = var.route_tables

  tags = merge(
    {
      Name = "rtb-${var.tags.Project}-${each.value}"
      Type = "rtb"
    },
    var.tags
  )
}

resource "aws_route" "this" {
  for_each               = var.route_tables

  route_table_id         = aws_route_table.this[each.value].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = each.value == "public" ? var.internet_gateway_id : null
  nat_gateway_id         = each.value == "public" ? null : var.nat_gateway_id
}