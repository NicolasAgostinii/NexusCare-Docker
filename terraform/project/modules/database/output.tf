
output "public_ip" {
  value = aws_instance.backend_ec2.public_ip
}
