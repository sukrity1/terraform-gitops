# --- Cluster Outputs ---

output "cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "The name of the ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "cluster_arn" {
  description = "The ARN of the ECS Cluster"
  value       = aws_ecs_cluster.main.arn
}

# --- Service Outputs ---

output "service_name" {
  description = "The name of the ECS Service"
  value       = aws_ecs_service.main.name
}

output "service_arn" {
  description = "The ARN of the ECS Service"
  value       = aws_ecs_service.main.id
}

// # --- IAM Role Outputs (Very important for Task Execution) ---

// output "task_role_arn" {
//   description = "The ARN of the IAM role that the Amazon ECS container agent and the Docker daemon can assume"
//   value       = aws_iam_role.ecs_task_role.arn
// }

// output "execution_role_arn" {
//   description = "The ARN of the IAM role that allows ECS to pull images and publish logs"
//   value       = aws_iam_role.ecs_exec_role.arn
// }

// # --- CloudWatch Log Group ---

// output "log_group_name" {
//   description = "The name of the CloudWatch log group for the ECS service"
//   value       = aws_cloudwatch_log_group.main.name
// }