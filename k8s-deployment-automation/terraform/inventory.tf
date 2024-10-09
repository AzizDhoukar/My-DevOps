resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  
  content = <<EOF
[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/${aws_key_pair.k8s-key.key_name}.pem

[k8s-master]
master ansible_host=${aws_instance.k8s-master.public_ip}

[k8s-worker]
node ansible_host=${aws_instance.k8s-worker.public_ip}
EOF
}
