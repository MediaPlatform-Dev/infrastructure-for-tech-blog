resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "sg-${var.tags.Project}-${var.resource_name}"
      Type = "sg"
    },
    var.tags
  )
}

resource "aws_security_group_rule" "this" {
  count = length(var.security_group_rules)

  security_group_id = aws_security_group.this.id

  type = var.security_group_rules[count.index]["type"]
  from_port = var.security_group_rules[count.index]["from_port"]
  to_port = var.security_group_rules[count.index]["to_port"]
  protocol = var.security_group_rules[count.index]["protocol"]
  cidr_blocks = [var.security_group_rules[count.index]["cidr_blocks"]]
}