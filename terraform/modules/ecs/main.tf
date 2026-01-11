# ECS Cluster configured for Fargate 
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled" # Recommended for monitoring
  }
}

# Security Group for ECS Tasks
resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-tasks-sg-${var.environment}"
  description = "Allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    # THIS USES THE VARIABLE WE JUST ADDED
    security_groups = [var.security_group_id] 
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Task Definition for the Java Application
resource "aws_ecs_task_definition" "app" {
  family                   = "java-api-task-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"] # 
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn #
  task_role_arn            = var.task_role_arn      #

  container_definitions = jsonencode([
    {
      name      = "java-app"
      image     = "${var.ecr_repository_url}:latest" #
      essential = true
      portMappings = [
        {
          containerPort = 8080 #
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
      # New Relic Agent Configuration
      environment = [
        { name = "NEW_RELIC_APP_NAME", value = "java-api-${var.environment}" },
        { name = "NEW_RELIC_LICENSE_KEY", value = "your_license_key_here" }
      ]
    }
  ])
}

# ECS Service configured to use the ALB
resource "aws_ecs_service" "main" {
  name            = "java-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = var.min_capacity

  network_configuration {
    subnets          = var.private_subnets # Tasks in private subnets
    security_groups  = [aws_security_group.ecs_tasks.id] # Use the SG defined above
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "java-app"
    container_port   = 8080
  }
}

# Auto-scaling Configuration 
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity # 3 
  min_capacity       = var.min_capacity # 1 
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# CPU-based Scaling Policy (Target: 70%) 
resource "aws_appautoscaling_policy" "cpu_policy" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = var.cpu_threshold # 70% 
  }
}