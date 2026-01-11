variable "service_name" {
  description = "The name of the service (e.g., java-api)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "retention_in_days" {
  description = "How many days to keep logs. Possible values: 1, 3, 5, 7, 14, 30, etc."
  type        = number
  default     = 7
}