resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "this" {
  key_name = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "this" {
  content = tls_private_key.this.private_key_pem
  filename = "${var.key_name}.pem"
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  key_name = aws_key_pair.this.key_name

  tags = merge(
    {
      Name = "ec2-${var.tags.Project}"
      Type = "ec2"
    },
    var.tags
  )
}