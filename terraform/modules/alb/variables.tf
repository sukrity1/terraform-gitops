variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the ALB"
  type        = list(string)
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID passed from the SG module"
  type        = string
}