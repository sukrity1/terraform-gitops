variable "environment" {}

variable "aws_region" {
  default = "us-east-1"
}

locals {
  account_id      = data.aws_caller_identity.current.account_id 
  bucket_name     = "tf-${local.account_id}-${var.aws_region}-${var.environment}"
  lock_table_name = "tf-locks-${var.environment}"
}