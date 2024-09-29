resource "local_file" "inventory" {
  filename = "${path.module}/Ansible/inventory.ini"
  
  content = <<EOF
[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/${aws_key_pair.jenkins_key.key_name}

[jenkins_master]
master ansible_host=${aws_instance.jenkins-server.public_ip}

[jenkins_nodes]
node ansible_host=${aws_instance.jenkins-node.public_ip}
EOF
}
