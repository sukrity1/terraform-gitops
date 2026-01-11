variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones for subnets"
  type        = number
}