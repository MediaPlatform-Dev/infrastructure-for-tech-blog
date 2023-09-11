output "id" {
  description = "The ID of the RDS"
  value       = aws_db_instance.this.id
}

output "arn" {
  description = "The ARN of the RDS"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  value = aws_db_instance.this.endpoint
}