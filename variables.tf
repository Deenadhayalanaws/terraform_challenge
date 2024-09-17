# AWS region
variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

# VPC ID
variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
  default     = "vpc-08eea79a880600dd5"
}

# EC2 Instance Variables
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  default     = "ami-0075013580f6322a1"  # Ubuntu 20.04 LTS in us-west-2
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  default     = "t2.micro"
}

# RDS Variables
variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  default     = "db.t2.micro"
}

variable "rds_engine" {
  description = "The database engine for RDS"
  default     = "mysql"
}
variable "db_name" {
  description = "The name of the database"
  default     = "mydb"
}

variable "db_username" {
  description = "The database master username"
  default     = "admin"
}
