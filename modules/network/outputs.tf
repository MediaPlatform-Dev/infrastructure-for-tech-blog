output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [ for k, sbn in aws_subnet.this : sbn.id if k < length(var.public_subnets) ]
}

output "private_subnet_ids" {
  value = [ for k, sbn in aws_subnet.this : sbn.id if k > length(var.public_subnets) - 1 ]
}