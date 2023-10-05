resource "aws_eip" "this" {
  vpc = true
  
  tags = merge(
    {
      Name = "eip-${var.tags.Project}"
      Type = "eip"
    },
    var.tags
  )
}