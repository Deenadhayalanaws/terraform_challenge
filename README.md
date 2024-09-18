Terraform AWS Infrastructure: EC2 with Nginx and RDS MySQL
Web server URL: http://54.244.180.195/
Overview
This Terraform configuration sets up the following infrastructure on AWS:

EC2 Instance: A virtual machine running Ubuntu with Nginx installed.
RDS MySQL Database: A managed MySQL database hosted on Amazon RDS.
Security Groups:
EC2 security group that allows SSH and HTTP traffic.
RDS security group that allows MySQL traffic only from the EC2 instance.
Resources
The following resources are provisioned by Terraform:

EC2 Instance: A single EC2 instance based on the provided Amazon Machine Image (AMI) and instance type.
Nginx Web Server: Automatically installed and started on the EC2 instance using a user-data script.
RDS MySQL Instance: A MySQL database managed by AWS RDS.
Security Groups:
EC2 Security Group allows inbound SSH (port 22) and HTTP (port 80) traffic.
RDS Security Group allows MySQL traffic (port 3306) only from the EC2 instance.
Prerequisites
Before running the Terraform script, ensure the following are set up:

AWS CLI: Installed and configured with credentials (aws configure) with permission to create EC2, RDS, and Security Groups.
AWS CLI Installation Guide
Terraform: Installed (version 1.0+).
Terraform Installation Guide
How to Deploy the Solution
Step 1: Clone the Repository
bash
Copy code
git clone <repository-url>
cd <repository-directory>
Step 2: Initialize Terraform
Run the following command to initialize your Terraform working directory:

bash
Copy code
terraform init
This will download and install any required provider plugins and modules.

Step 3: Customize Variables
There are several variables that you can customize. These can either be passed via the command line, in a terraform.tfvars file, or by modifying the variables.tf file directly.

Here are the available variables:

region: The AWS region where resources will be deployed (e.g., us-east-1).
ami_id: The AMI ID to use for the EC2 instance (e.g., ami-0c55b159cbfafe1f0).
instance_type: The EC2 instance type (e.g., t2.micro).
rds_instance_class: The RDS instance type (e.g., db.t3.micro).
rds_engine: The database engine for RDS (default: mysql).
db_name: The name of the MySQL database (e.g., mydb).
db_username: The username for MySQL (e.g., admin).
db_password: The password for the MySQL database (default: password123).
You can create a terraform.tfvars file to override default values:

bash
Copy code
# terraform.tfvars
region         = "us-west-2"
ami_id         = "ami-0abcdef1234567890"
instance_type  = "t2.micro"
rds_instance_class = "db.t3.micro"
db_name        = "mydb"
db_username    = "admin"
db_password    = "supersecurepassword"
Step 4: Plan and Apply Terraform
Before applying the infrastructure, you can run a plan to preview the actions Terraform will take:

bash
Copy code
terraform plan
If the plan looks good, apply the configuration:

bash
Copy code
terraform apply
Type yes to confirm the changes.

Step 5: Accessing the Resources
EC2 Instance
Once the infrastructure is created, you can SSH into the EC2 instance using the public IP provided in the output:

bash
Copy code
ssh -i /path/to/your-key.pem ubuntu@<ec2-public-ip>
Nginx Web Server
Nginx should be installed and running on the EC2 instance. To verify, you can open the EC2 instance’s public IP in a browser:

vbnet
Copy code
http://<ec2-public-ip>
MySQL Database
To connect to the MySQL database from the EC2 instance:

bash
Copy code
mysql -h <rds-endpoint> -u <db-username> -p
You will be prompted to enter the RDS MySQL password.

Step 6: Clean Up Resources
To prevent unnecessary costs, you should destroy the infrastructure when it's no longer needed:

bash
Copy code
terraform destroy
Type yes to confirm the deletion.

File Structure
bash
Copy code
.
├── main.tf                # Main Terraform configuration file
├── variables.tf           # Variables file for customization
├── outputs.tf             # Outputs file (EC2 public IP, RDS endpoint)     
├── README.md              # Documentation for this setup
Variables Breakdown
region: AWS region where resources are created (default: us-east-1).
ami_id: AMI ID to launch the EC2 instance (default: Ubuntu AMI).
instance_type: EC2 instance type (default: t2.micro).
rds_instance_class: RDS instance class (default: db.t3.micro).
rds_engine: Type of RDS engine (default: mysql).
db_name: Name of the database created in RDS.
db_username: Username for the MySQL RDS instance.
db_password: Password for the MySQL RDS instance (default: password123).

Notes:
EC2 Nginx: Nginx is automatically installed and started on the EC2 instance using a user-data script.
RDS Security: The RDS instance is not publicly accessible and can only be accessed from the EC2 instance through the configured security groups.

Intiali
