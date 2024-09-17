# Output the EC2 instance public IP
output "ec2_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

# Output the RDS instance endpoint
output "rds_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

# Output the RDS database name
output "rds_db_name" {
  description = "The name of the database"
  value       = aws_db_instance.rds_instance.name
}

# Output the VPC ID
output "vpc_id" {
  description = "The VPC ID used for deploying the resources"
  value       = var.vpc_id
}
