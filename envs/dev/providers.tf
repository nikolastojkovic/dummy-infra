locals {
  default_tags = {
    Project_name = var.project_name
    Environment  = var.env
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = "eu-central-1" # dev

  default_tags {
    tags = local.default_tags
  }
}
