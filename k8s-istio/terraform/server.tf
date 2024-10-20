# The key is in the local machine
resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = file("C:/Users/ZD/.ssh/k8s-key.pub")  # Ensure this path is correct and the file exists
}

# Fetch the latest Amazon Linux Image (AMI) owned by AWS
data "aws_ami" "ubuntu-latest" {
  most_recent = true
  
  owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Define the servers
resource "aws_instance" "k8s-master" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.ubuntu-latest.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.k8s-key.key_name
  subnet_id                   = aws_subnet.k8s-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.k8s-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

resource "aws_instance" "k8s-worker" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.ubuntu-latest.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.k8s-key.key_name
  subnet_id                   = aws_subnet.k8s-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.k8s-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  tags = {
    Name = "${var.env_prefix}-node"
  }
}