variable "ami_id" {}
variable "vpc_id" {}
variable "subnet_id" {}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "iam_instance_profile_name" {
  default = ""
}

variable "ec2_role_arn" {
  default = ""
}

locals {
  project_name = "demo-app"
}

module "app_infra" {
  source       = "../../modules/app_infra"
  env          = "dev"
  project_name = local.project_name

  ami_id    = var.ami_id
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  instance_type             = "t3.micro"
  ssh_cidr                  = var.ssh_cidr
  iam_instance_profile_name = var.iam_instance_profile_name
  ec2_role_arn              = var.ec2_role_arn

  tags = {
    Project     = local.project_name
    Environment = "dev"
    Owner       = "platform-team"
  }
}

output "s3_bucket_name" {
  value = module.app_infra.s3_bucket_name
}

output "ec2_instance_id" {
  value = module.app_infra.ec2_instance_id
}
