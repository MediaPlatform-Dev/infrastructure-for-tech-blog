resource "aws_security_group" "this" {
    name   = "${var.tags.Environment}-sg-ec2"
    vpc_id = var.vpc_id

    tags = merge(
    {
        Name = "${var.tags.Environment}-sg-ec2"
        Type = "sg"
    },
    var.tags
    )
}