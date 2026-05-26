output "endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "RDS PostgreSQL endpoint"
}

output "port" {
  value       = aws_db_instance.this.port
  description = "Database port"
}

output "db_name" {
  value       = aws_db_instance.this.db_name
}

output "security_group_id" {
  value       = aws_security_group.this.id
}

output "db_subnet_group_name" {
  value       = aws_db_subnet_group.this.name
}