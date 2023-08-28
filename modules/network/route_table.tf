# VPC 생성 시 기본으로 생성되는 Route table에 이름을 붙입니다
# 이걸 Subnet에 연결해 써도 되지만, 여기서는 사용하지 않습니다
resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-rtb-default"
      Type = "rtb"
    },
    var.tags
  )
}

# Subnet에 적용할 Route table 생성
resource "aws_route_table" "this" {
  vpc_id   = aws_vpc.this.id
  
  for_each = var.route_tables

  tags = merge(
    {
      Name = "${var.tags.Environment}-rtb-${each.value}"
      Type = "rtb"
    },
    var.tags
  )
}

# Public Subnet에서 인터넷에 트래픽 요청시 앞서 정의한 Internet gateway로 보냅니다
# Private Subnet에서 인터넷에 트래픽 요청시 앞서 정의한 NAT gateway로 보냅니다
resource "aws_route" "this" {
  for_each               = var.route_tables

  route_table_id         = aws_route_table.this[each.value].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = each.value == "public" ? aws_internet_gateway.this.id : null
  nat_gateway_id         = each.value == "public" ? null : aws_nat_gateway.this.id

  depends_on = [
    aws_internet_gateway.this,
    aws_nat_gateway.this
  ]
}