resource "aws_instance" "cerberus" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("./bash.sh") //the code in bash.sh will be executed on the EC2 instance, but it's better to use an ami with the necessary software already installed
  key_name = aws_key_pair.cerberus-key.key_name
}

resource "aws_key_pair" "cerberus-key" {
  key_name   = "cerberus"
  public_key = file(".ssh/cerberus.pub")// This file must exist and contain a valid public key
}

resource "aws_eip" "eip" { 
  domain         = "vpc"
  instance = aws_instance.cerberus.id 
  
  provisioner "local-exec" { // This provisioner will run on the machine running Terraform, not on the EC2 instance
    command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"
  }
}
