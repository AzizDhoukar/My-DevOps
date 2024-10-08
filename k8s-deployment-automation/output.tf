# Output the EC2 instance's public IP
output "jenkins-server_public_ip" {
  value = aws_instance.jenkins-server.public_ip
}
output "jenkins-node_public_ip" {
  value = aws_instance.jenkins-node.public_ip
}