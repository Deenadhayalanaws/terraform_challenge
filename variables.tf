variable "region" {
  description = "The AWS region to deploy in"
  default     = "us-west-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0075013580f6322a1" # Ubuntu 20.04 AMI
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID where the infrastructure will be deployed"
default     = "vpc-08eea79a880600dd5"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  default     = "db.t4g.micro"    #db.t2.micro not available now so im used this
}

variable "rds_engine" {
  description = "RDS engine"
  default     = "mysql"
}

variable "db_name" {
  description = "Terraform challenge"
default     = "terraform_challenge"
}

variable "db_username" {
  description = "Deena"
  default     = "Deena"
}

variable "db_password" {
  description = "Deena"
  default     = "Dhayalan#2024"
}

