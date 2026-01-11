module "ecr" {
  source            = "../modules/ecr"
  repository_name   = "java-api-repo-${var.environment}"
  environment       = var.environment
  image_tag_mutability = "MUTABLE"
  max_image_count   = 30
}