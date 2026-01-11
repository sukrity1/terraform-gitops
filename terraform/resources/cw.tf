module "cloudwatch" {
  source            = "../modules/cw"
  service_name      = "java-api"
  environment       = var.environment
  retention_in_days = 14
}