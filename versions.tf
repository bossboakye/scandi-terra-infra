# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "scandytfstate"
    key    = "scandyproj.tfstate"
    region = "us-east-2"
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}
