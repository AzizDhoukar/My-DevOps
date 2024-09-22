# The key is in the local machine
resource "aws_key_pair" "K8S_key" {
  key_name   = "K8S_key"
  public_key = file("C:/Users/ZD/.ssh/K8S_key.pub")  # Ensure this path is correct and the file exists
}

# Fetch the latest Amazon Linux Image (AMI) owned by AWS
data "aws_ami" "amazon-latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Define the K8S master server
resource "aws_instance" "master-server" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.amazon-latest.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.K8S_key.key_name
  subnet_id                   = aws_subnet.K8S-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.master-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  # Specify a script to be executed when the instance is launched
  user_data                   = file("master.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}