variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "private_subnet" {
  description = "Subnets CIDR"
  type        = list(string)
}