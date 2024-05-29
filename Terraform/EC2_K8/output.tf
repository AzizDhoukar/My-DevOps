# Output the EC2 instance's public IP
output "master_public_ip" {
  value = aws_eip.master_ip.public_ip
}
output "worker_public_ip" {
  value = aws_eip.worker_ip.public_ip
}