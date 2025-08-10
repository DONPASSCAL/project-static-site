provider "aws" {
  region = "us-east-2"
}

# resource "aws_key_pair" "ohiokey" {
#   key_name   = "ohiokey"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "website" {
  ami           = "ami-0d1b5a8c13042c939" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name = "ohiokey"
  security_groups = [aws_security_group.web_sg.name]

  user_data = file("${path.module}/../scripts/setup.sh")

  tags = {
    Name = "StaticSiteServer"
  }
}
