variable "ami" {
  default = "ami-0f3d898ae42d775a6" // This is the AMI for Amazon Linux 2023
}
variable "instance_type" {
  default = "t2.micro"
}
variable "region" {
  default = "eu-central-1"
}