variable "environment" {
  description = "Environment to analyze"
  type        = string
}

variable "project_path" {
  description = "The path to the terraform root directory"
  type        = string
  default     = "."
}