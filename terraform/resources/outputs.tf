output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

// output "ecr_repository_url" {
//   description = "The URL of the ECR repository"
//   value       = aws_ecr_repository.app.repository_url
// }