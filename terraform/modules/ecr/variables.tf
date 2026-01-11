variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags are mutable or immutable"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable vulnerability scanning on image push"
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Maximum number of images to retain"
  type        = number
  default     = 20
}