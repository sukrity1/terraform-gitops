module "vpc" {
  source               = "../modules/vpc"
  cidr_block           = var.vpc_cidr
  az_count             = var.az_count
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
  // availability_zones   = ["us-east-1a", "us-east-1b"] # Minimum 2 AZs 
  environment          = var.environment
}