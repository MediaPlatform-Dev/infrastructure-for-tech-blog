# Public Subnet에 연결할 Internet gateway 생성
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = merge(
    {
      Name = "${var.tags.Environment}-igw"
      Type = "igw"
    },
    var.tags
  )
}