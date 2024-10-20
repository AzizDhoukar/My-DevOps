# Security Group of the server
resource "aws_default_security_group" "k8s-sg" {
  vpc_id = aws_vpc.my-vpc.id  
  # Allow inbound TCP traffic on port 22 (SSH) from any source 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  # Allow inbound TCP traffic on port 8080 from any source.
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }  
  # Allow ICMP (ping) traffic between the master and worker nodes
  ingress {
    description = "Allow ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]
  }
    # Allow ICMP traffic between the master and worker nodes
  ingress {
    description = "Allow K8S communications"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    self        = true
  }
  # Allow all outbound traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}