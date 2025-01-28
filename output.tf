output "instance_public_ip" {
  value = aws_instance.php_server.public_ip
}

output "db_endpoint" {
  description = "The endpoint of the RDS MySQL instance"
  value       = aws_db_instance.mysql.endpoint
}

output "db_port" {
  description = "The port of the RDS MySQL instance"
  value       = aws_db_instance.mysql.port
}

