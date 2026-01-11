variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for Fargate tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "ecr_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "cpu_threshold" {
  description = "Target CPU utilization for auto-scaling"
  type        = number
  default     = 70 # [cite: 185]
}

variable "min_capacity" {
  description = "Minimum number of running tasks"
  type        = number
  default     = 1 # [cite: 185]
}

variable "max_capacity" {
  description = "Maximum number of running tasks"
  type        = number
  default     = 3 # [cite: 185]
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the ALB security group to allow traffic from"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group for container logs"
  type        = string
}

variable "aws_region" {
  description = "The name of the region"
  type        = string
}