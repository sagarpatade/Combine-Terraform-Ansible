output "nginx_server_ip" {
  description = "Public IP of the Nginx Server"
  value       = aws_instance.nginx-ec2.public_ip
}