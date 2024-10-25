output "app_private_ip" {
  value = aws_instance.app.private_ip
}

output "app_id" {
  value = aws_instance.app.id
}
