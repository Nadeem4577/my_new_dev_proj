terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0fc82f4dabc05670b" # Amazon Linux 2
  instance_type = "t2.micro"

  user_data = <<-EOF
                  #!/bin/bash
                  sudo yum install docker -y
                  sudo systemctl start docker
                  sudo docker run -d -p 80:80 my-web-app:latest
                  EOF

  tags = {
    Name = "DevOps-Web-Server"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"

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
