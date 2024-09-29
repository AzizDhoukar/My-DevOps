# The key is in the local machine
resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_key"
  public_key = file("C:/Users/ZD/.ssh/jenkins_key.pub")  # Ensure this path is correct and the file exists
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

# Define the Jenkins server
resource "aws_instance" "jenkins-server" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.ubuntu-latest.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.jenkins_key.key_name
  subnet_id                   = aws_subnet.jenkins-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.jenkins-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  # Specify a script to be executed when the instance is launched
  user_data                   = file("jenkins_server.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

resource "aws_instance" "jenkins-node" {
  # Specify the AMI id defined above
  ami                         = data.aws_ami.ubuntu-latest.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.jenkins_key.key_name
  subnet_id                   = aws_subnet.jenkins-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.jenkins-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  # Specify a script to be executed when the instance is launched
  user_data                   = file("jenkins_node.sh")
  tags = {
    Name = "${var.env_prefix}-node"
  }
}