provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "MyEC2Instance"
    env = var.env
  }
  
}

