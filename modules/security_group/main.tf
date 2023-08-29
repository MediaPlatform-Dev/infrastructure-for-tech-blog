resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  for_each = var.security_groups

  tags = merge(
    {
      Name = "sg-${var.tags.Project}-${each.key}"
      Type = "sg"
    },
    var.tags
  )
}

resource "aws_security_group_rule" "this" {
  
}