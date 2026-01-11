variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  // default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, staging)"
  // default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  // default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones for subnets"
  type        = number
}

variable "domain_name" {
  description = "The root domain name for the hosted zone"
  type        = string
}

variable "sgname" {
  description = "The SG name"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

// variable "availability_zones" {
//   type        = list(string)
//   description = "List of AZs to use for the VPC"
//   // default = ["us-east-1a", "us-east-1b"]
// }