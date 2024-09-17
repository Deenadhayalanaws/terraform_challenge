provider "aws" {
  region = var.region
}

# Security Group for EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ec2_sg"
  }
}

# Ingress rule for SSH (port 22)
resource "aws_vpc_security_group_ingress_rule" "ssh_ingress" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Ingress rule for HTTP (port 80)
resource "aws_vpc_security_group_ingress_rule" "http_ingress" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Egress rule for EC2
resource "aws_vpc_security_group_egress_rule" "ec2_egress" {
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security Group for RDS instance
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Allow MySQL traffic from EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "rds_sg"
  }
}

# Ingress rule for MySQL (port 3306)
resource "aws_vpc_security_group_ingress_rule" "mysql_ingress" {
  security_group_id = aws_security_group.rds_sg.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.ec2_sg.id
}

# Egress rule for RDS
resource "aws_vpc_security_group_egress_rule" "rds_egress" {
  security_group_id = aws_security_group.rds_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "ec2_instance"
  }
}

# RDS MySQL instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  instance_class       = var.rds_instance_class
  engine               = var.rds_engine
  engine_version       = "8.0"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "rds_instance"
  }
}

