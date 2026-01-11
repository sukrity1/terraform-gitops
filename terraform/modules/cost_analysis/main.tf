data "external" "infracost" {
  program = ["sh", "${path.module}/get_cost.sh"]
}

# This will now appear in your 'terraform plan' output
output "estimated_monthly_cost" {
  value = data.external.infracost.result.monthly_cost
}

resource "null_resource" "cost_estimate" {
  # Trigger this every time the plan changes
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "--- COST ANALYSIS FOR ${var.environment} ---"
      infracost breakdown --path ${var.project_path} --format table
      echo "--- COST SAVINGS RECOMMENDATIONS ---"
      infracost comment github --path /tmp/infracost.json --behavior update || echo "Run 'infracost output' to see recommendations like: Switching to Graviton instances or using Spot instances for non-critical ECS tasks."
    EOT
  }
}