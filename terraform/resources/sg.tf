module "alb_security_group" {
  sgname      = var.sgname
  source      = "../modules/sg" 
  environment = var.environment
  vpc_id      = module.vpc.vpc_id

  # Pass the list of objects to the dynamic block
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    // },
    // {
    //   from_port   = 443
    //   to_port     = 443
    //   protocol    = "tcp"
    //   cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}