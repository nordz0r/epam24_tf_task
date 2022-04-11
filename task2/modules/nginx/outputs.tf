# Outputs
output "nginx_public_dns" {
  value = aws_instance.nginx.public_dns
}