# Output the EC2 instance's public IP
output "instance_public_ip" {
  value = aws_eip.eip.public_ip
}