provider "aws" {
  region = var.region
}

# Security Group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

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
    cidr_blocks = ["0.0.0.0/0"]  # Correct plural form
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Correct plural form
  }

  tags = {
    Name = "ec2_sg"
  }
}
# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]

  # User data to install Nginx
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "ec2_instance_with_nginx"
  }
}
