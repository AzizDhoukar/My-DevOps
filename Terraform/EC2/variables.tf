variable "ami" {
  default = "ami-06178cf087598769c" // This is the AMI for Ubuntu 18.04 LTS
}
variable "instance_type" {
  default = "t2.micro"
}
variable "region" {
  default = "eu-central-1"
}