#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Step 1: Running Terraform Plan..."
echo "----------------------------------------------------"
# Run plan and save it to a file
terraform plan -out=tfplan.binary

echo ""
echo "----------------------------------------------------"
echo "Step 2: Analyzing Costs (Infracost)..."
echo "----------------------------------------------------"
# Use Infracost to read the binary plan and print the table
infracost breakdown --path tfplan.binary --format table
infracost breakdown --path tfplan.binary --format json --out-file infracost.json > /dev/null

# echo ""
# echo "----------------------------------------------------"
# echo "Step 3: Cost Savings Recommendations"
# echo "----------------------------------------------------"
# # This scans ALL files for ALL AWS services in your folder.
# # --quiet: Only shows failed checks (the recommendations you need to fix).
# # --compact: keeps the output readable.
# checkov -d . \
#   --framework terraform \
#   --quiet \
#   --compact \
#   --check CKV_AWS_78,CKV_AWS_96,CKV_AWS_120,CKV_AWS_139,CKV_AWS_300

# echo "----------------------------------------------------"
# echo "Step 3: Security & Best Practice Scan"
# echo "----------------------------------------------------"

# # --soft-fail: Runs the scan but allows the script to continue (good for learning)
# # Remove --soft-fail if you want the script to STOP on security errors.
# checkov -d . \
#   --framework terraform \
#   --quiet \
#   --compact \
#   --check HIGH,CRITICAL