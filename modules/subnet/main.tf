resource "aws_subnet" "this" {
  count             = length(var.subnet_cidr_blocks)

  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zone[count.index]
  map_public_ip_on_launch = var.visibility == "public" ? true : false
  
  tags = merge(
    {
      Name = "sbn-${var.tags.Project}-${var.visibility}-${count.index}"
      Type = "sbn"
    },
    var.tags
  )
}