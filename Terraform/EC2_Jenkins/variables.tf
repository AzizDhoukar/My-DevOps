variable "ami" {
  default = "ami-0f3d898ae42d775a6" // This is the AMI for Amazon Linux 2023
}
variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "availability_zone" {}
variable "env_prefix" {}
variable "instance_type" {}