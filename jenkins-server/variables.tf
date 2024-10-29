variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "instance_type" {
  description = "Jenkins server instance type"
  type        = string
}