# Generate a new key pair
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("C:/Users/ZD/.ssh/my-key.pub")  # Ensure this path is correct and the file exists
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing SSH from anywhere. For production, restrict to your IP.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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

# Create an EC2 instance
resource "aws_instance" "cerberus" {
  ami           = data.aws_ami.ubuntu-latest.id  # Replace with your desired AMI ID
  instance_type = var.instance_type  # Replace with your desired instance type
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  user_data     = file("./bash.sh")  # Ensure this path is correct

  tags = {
    Name = "Cerberus"
  }
}

# Allocate and associate an Elastic IP
resource "aws_eip" "eip" {
  instance = aws_instance.cerberus.id
  domain         = "vpc"
}


