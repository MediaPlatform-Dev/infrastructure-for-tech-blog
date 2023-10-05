output "ids" {
  value = [ for k, rtb in aws_route_table.this : rtb.id ]
}