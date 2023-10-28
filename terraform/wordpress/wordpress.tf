provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wordpress_ec2_instance" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  associate_public_ip_address = true
  user_data = file("cloud-init.yml")
  tags = {
    Name = "${local.wordpress_ec2_name}"
  }
}