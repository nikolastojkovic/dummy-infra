variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance in eu-central-1"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 instance and security group will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH into the EC2 instance"
  type        = string
  default     = "0.0.0.0/0"
}

variable "iam_instance_profile_name" {
  description = "Optional IAM instance profile name for the EC2 instance"
  type        = string
  default     = ""
}

variable "ec2_role_arn" {
  description = "Optional IAM role ARN used for S3 bucket policy"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "demo-app-staging"
}
