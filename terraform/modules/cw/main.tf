resource "aws_cloudwatch_log_group" "main" {
  # Naming convention: /ecs/env/service-name
  name              = "/ecs/${var.environment}/${var.service_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Name        = "${var.service_name}-logs"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}