aws_region = "us-east-1"
environment = "prod"
vpc_cidr = "172.0.0.0/16"
az_count = "2"
domain_name = "prod.example.com"
sgname = "alb"
ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
// availability_zones