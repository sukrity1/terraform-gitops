#!/bin/bash
# Run infracost and capture the total monthly cost
COST=$(infracost breakdown --path . --format json | jq -r '.totalMonthlyCost // "0"')
# Terraform expects a JSON object back
echo "{\"monthly_cost\": \"$COST\"}"