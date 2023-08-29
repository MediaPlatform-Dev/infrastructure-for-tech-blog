resource "aws_instance" "this" {
  availability_zone  = var.availability_zone

  ami           = var.ami
  instance_type = var.instance_type

  subnet_id     = var.subnet_id

  tags = merge(
    {
      Name = "ec2-${var.tags.Project}"
      Type = "ec2"
    },
    var.tags
  )
}