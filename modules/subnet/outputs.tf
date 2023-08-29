output "ids" {
  value = [ for k, sbn in aws_subnet.this : sbn.id ]
}