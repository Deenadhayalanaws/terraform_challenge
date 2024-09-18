provider "aws" {
  region = var.region
}

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP inbound traffic"

  tags = {
    Name = "EC2 Security Group"
  }
}

# SSH Ingress Rule for EC2
resource "aws_security_group_rule" "ssh_ingress" {
  type        = "ingress"
   from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

# HTTP Ingress Rule for EC2
resource "aws_security_group_rule" "http_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
 }

# EC2 Egress Rule
resource "aws_security_group_rule" "ec2_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL traffic from EC2"
 tags = {
    Name = "RDS Security Group"
  }
}

# MySQL Ingress Rule for RDS
resource "aws_security_group_rule" "mysql_ingress" {
  type            = "ingress"
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  source_security_group_id = aws_security_group.ec2_sg.id
  security_group_id = aws_security_group.rds_sg.id
}
# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "EC2 Instance"
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
              EOF
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  instance_class       = var.rds_instance_class
  engine               = var.rds_engine
  engine_version       = "8.0.35"
  db_name              = var.db_name          # This is for the database name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "RDS Instance"
}
}
