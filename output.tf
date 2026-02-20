output "direccion_ip_wordpress" {
  description = "Dirección IP pública del servidor EC2"
  value       = aws_instance.ec2_wordpress.public_ip
}

output "endpoint_base_datos" {
  description = "Punto de enlace de la base de datos RDS"
  value       = aws_db_instance.base_datos_wp.endpoint
}