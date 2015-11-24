variable "aws_region" {
  description = "The AWS region to create things in."
  default = "eu-west-1"
}

variable "spinnaker_amis" {
	default = {
		eu-west-1 = "ami-7537ed06"
		us-east-1 = "ami-3acb8e50"
		us-west-1 = "ami-a1ed83c1"
		us-west-2 = "ami-ef65758e"
		eu-central-1 = "ami-18253774"
		ap-southeast-1 = "ami-899a5bea"
		ap-southeast-2 = "ami-f5411896"
		ap-northeast-1 = "ami-0cc2e162"
		sa-east-1 = "ami-3a2c9656"
	}
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "key_name" {
    description = "SSH Key Name"
    default = "spinnaker-testing"
}