# NAT gateway는 고정 IP를 필요로 합니다
resource "aws_eip" "this" {
  vpc = true

  depends_on = [
    aws_vpc.this
  ]
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-eip-natgw"
      Type = "eip"
    },
    var.tags
  )
}