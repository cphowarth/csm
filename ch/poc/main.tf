#####################################################################
##
##      Created 1/23/19 by admin. for poc
##
#####################################################################

## REFERENCE {"aws_network_ch":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  version = "~> 1.8"
}


data "aws_subnet" "subnetch" {
  vpc_id = "${var.vpc_id}"
  availability_zone = "${var.availability_zone}"
}

resource "random_pet" "citi-pet" {
}

resource "aws_instance" "awsvm" {
  ami = "${var.awsvm_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.awsvm_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${data.aws_subnet.subnetch.id}"
  tags {
    Name = "${var.awsvm_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${random_pet.citi-pet.id}"  # random_pet
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}