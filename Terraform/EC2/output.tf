# Output the EC2 instance's public IP
output "instance_public_ip" {
  value = aws_instance.cerberus.public_ip
}