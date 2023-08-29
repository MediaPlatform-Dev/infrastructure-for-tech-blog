resource "aws_eip" "this" {
  vpc = var.vpc
  
  tags = merge(
    {
      Name = "eip-${var.tags.Project}"
      Type = "eip"
    },
    var.tags
  )
}