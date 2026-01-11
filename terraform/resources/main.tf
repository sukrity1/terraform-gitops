module "cost_estimation" {
   source       = "../modules/cost_analysis"
   environment  = var.environment
   project_path = "."
 }