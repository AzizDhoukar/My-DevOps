# Generate a new key pair
resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_key"
  public_key = file("C:/Users/ZD/.ssh/jenkins_key.pub")  # Ensure this path is correct and the file exists
}

# Create a security group to allow SSH access
resource "aws_security_group" "jenkins_security_group" {
  name        = "jenkins_security_group"
  description = "Allow SSH inbound traffic and HTTP access"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider restricting to your IP address for better security
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "cerberus" {
  ami           = var.ami  # Replace with your desired AMI ID
  instance_type = var.instance_type  # Replace with your desired instance type
  key_name      = aws_key_pair.jenkins_key.key_name
  security_groups = [aws_security_group.jenkins_security_group.name]
  user_data     = file("./bash.sh")  # Ensure this path is correct

  tags = {
    Name = "Jenkins-Server"
  }
}

# Allocate and associate an Elastic IP
resource "aws_eip" "eip" {
  instance = aws_instance.cerberus.id
  domain         = "vpc"
}
