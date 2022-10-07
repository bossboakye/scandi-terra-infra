# AWS Region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance Type"
  type        = string
  default     = "t2.medium"
}

# AWS EC2 Instance Key Pair
variable "aws_key_pair" {
  description = "AWS Key pair to connent to instances"
  type        = string
  default     = "monty"
}

# AWS VPC
variable "aws_vpc" {
  description = "AWS VPC"
  type        = string
  default     = "vpc-0adab20cf6a9658a3"
}

# VPC Public Subnets
variable "vpc_public_subnets_1" {
  description = "VPC Public Subnets"
  type        = string
  default     = "subnet-05fb408b1e808e368"
}

variable "vpc_public_subnets_2" {
  description = "VPC Public Subnets"
  type        = string
  default     = "subnet-0647cee0d1ea15ab0"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

# AWS ACM
variable "acm" {
  type        = string
  description = "acm arn"
  default     = "arn:aws:acm:us-east-2:967467310537:certificate/d62c9af9-5203-4078-bd6f-52426f01eb2d"
}