# Private Subnet에서 인터넷 접속시 사용할 NAT gateway 생성
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.this[0].id # NAT 게이트웨이 자체는 퍼플릭 서브넷에 위치해야 합니다
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-nat"
      Type = "nat"
    },
    var.tags
  )
}