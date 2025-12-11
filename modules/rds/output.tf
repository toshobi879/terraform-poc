output "db_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.database.endpoint
}

output "db_port" {
  description = "RDS endpoint port"
  value       = aws_db_instance.database.port
}

output "security_group_id" {
  description = "Security group for RDS"
  value       = aws_security_group.db_sg.id
}

output "db_identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.database.id
}
