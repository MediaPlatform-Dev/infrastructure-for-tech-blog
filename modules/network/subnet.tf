# Subnet 생성
resource "aws_subnet" "this" {
  count             = length(var.subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(split("-", var.subnets[count.index]), 2)
  availability_zone = var.availability_zones[element(split("-", var.subnets[count.index]), 1)]
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-sbn-${element(split("-", var.subnets[count.index]), 0)}-${element(split("-", var.subnets[count.index]), 1)}"
      Type = "sbn"
    },
    var.tags
  )
}

# Subnet을 Route table에 연결
resource "aws_route_table_association" "this" {
  count          = length(var.subnets)

  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this[element(split("-", var.subnets[count.index]), 0)].id
}