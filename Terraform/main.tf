provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "MyFirstEC2Instance"
  }
  
}

