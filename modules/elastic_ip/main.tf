resource "aws_eip" "this" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
  
  tags = merge(
    {
      Name = "eip-${var.tags.Project}"
      Type = "eip"
    },
    var.tags
  )
}