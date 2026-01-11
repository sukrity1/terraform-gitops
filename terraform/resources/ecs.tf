module "ecs" {
  depends_on            = [module.alb_security_group, module.cloudwatch.log_group_name]
  aws_region            = var.aws_region
  source                = "../modules/ecs"
  cluster_name          = "java-api-cluster-${var.environment}" # Fargate launch type
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  target_group_arn      = module.alb.target_group_arn
  execution_role_arn    = module.iam.task_execution_role_arn
  task_role_arn         = module.iam.task_role_arn
  ecr_repository_url    = module.ecr.repository_url
  cpu_threshold         = 70 # Auto-scaling target
  min_capacity          = 1
  max_capacity          = 3
  environment           = var.environment
  security_group_id     = module.alb_security_group.security_group_id
  log_group_name        = module.cloudwatch.log_group_name
}