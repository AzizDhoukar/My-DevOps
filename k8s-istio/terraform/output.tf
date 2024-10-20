# Output the EC2 instance's public IP
output "k8s-master_public_ip" {
  value = aws_instance.k8s-master.public_ip
}
output "k8s-worker_public_ip" {
  value = aws_instance.k8s-worker.public_ip
}