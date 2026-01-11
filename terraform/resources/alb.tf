module "alb" {
  depends_on         = [module.alb_security_group]
  source             = "../modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  environment        = var.environment
  security_group_id = module.alb_security_group.security_group_id
}