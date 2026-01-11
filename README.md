🚀 `Java REST API Infrastructure (ECS Fargate)`
This repository contains a production-ready, containerized Java 17 application deployed on AWS ECS Fargate. The infrastructure is managed via Terraform and includes integrated New Relic APM monitoring and Infracost analysis.

🏗 `Infrastructure Overview`
The architecture is designed for high availability, security, and scalability. It leverages a multi-AZ VPC layout with public and private subnets.

```
Architecture Diagram
                                 ___________________________________________________
                                |                  AWS Region (us-east-1)           |
                                |___________________________________________________|
                                         |
                                  _______v_______
                                 |   Route 53    | (DNS Entry)
                                 |_______________|
                                         |
          _______________________________v____________________________________________
         |                                VPC                                         |
         |   ______________________________________________________________________   |
         |  |             Availability Zone A      |      Availability Zone B      |  |
         |  |______________________________________|_______________________________|  |
         |  |                                      |                               |  |
         |  |      [ Public Subnet A ]             |      [ Public Subnet B ]      |  |
         |  |    ______________________            |    ______________________     |  |
         |  |   |                      |           |   |                      |    |  |
         |  |   |  Internet Gateway    |<----------+-->|  Application Load    |    |  |
         |  |   |______________________|           |   |       Balancer       |    |  |
         |  |              |                       |   |________(ALB)_________|    |  |
         |  |______________|_______________________|______________|________________|  |
         |                 |                                      |                    |
         |   ______________v______________________________________v________________    |
         |  |                                      |                               |  |
         |  |      [ Private Subnet A ]            |      [ Private Subnet B ]     |  |
         |  |    ______________________            |    ______________________     |  |
         |  |   |                      |           |   |                      |    |  |
         |  |   |   ECS Fargate Task   |<----------+-->|   ECS Fargate Task   |    |  |
         |  |   |   (Java Container)   |           |   |   (Java Container)   |    |  |
         |  |   |______________________|           |   |______________________|    |  |
         |  |______________|_______________________|______________|________________|  |
         |                 |                                      |                    |
         |_________________|______________________________________|____________________|
                           |                                      |
          _________________v_________________    _________________v_________________
         |                                   |  |                                   |
         |        CloudWatch Logs            |  |          ECR Repository           |
         |      (7-day retention)            |  |        (Docker Image Storage)     |
         |___________________________________|  |___________________________________|
                           |
          _________________v_________________
         |                                   |
         |       New Relic APM Dashboard     |
         |      (Monitoring & Alerting)      |
         |___________________________________|
```

🛠 `Prerequisites & Setup`
Before you begin, ensure you have the following installed:

Terraform 1.5+

AWS CLI (v2)

Docker Desktop

Java 17 & Maven

Infracost CLI (for local cost checks)

🚀 `Deployment Guide`
1. Provision Infrastructure with Terraform
The project is divided into two phases: Bootstrap (remote state) and Resources (active infra).

`Phase A: Bootstrap (Remote State)`

cd devops-take-home/terraform/bootstrap
terraform init
terraform plan -var-file=tfvars/dev.tfvars
# Preview costs locally
infracost breakdown --path . --terraform-var-file="tfvars/dev.tfvars"
terraform apply -var-file=tfvars/dev.tfvars

`Phase B: Resources (Application Infra)`
cd devops-take-home/terraform/resources
# Export current credentials
eval $(aws configure export-credentials --profile default --format env)

# For DEV Environment
terraform init -backend-config=environments/dev/dev.config
terraform plan -var-file=environments/dev/dev.tfvars
terraform apply -var-file=environments/dev/dev.tfvars

Note: For stg or prod, simply swap the dev string in the paths above with the respective environment name.

2. Build & Run Application Locally
# Build the Java artifact
mvn clean package -DskipTests

# Build Docker Image
docker build -t java-api -f docker/Dockerfile .

# Run locally with New Relic Integration
docker run -p 80:8080 \
  -e NEW_RELIC_LICENSE_KEY="YOUR_LICENSE_KEY" \
  --name java-app java-api

🔐 `Credentials & GitHub Secrets`
This project uses OIDC (OpenID Connect) for secure AWS authentication via GitHub Actions, eliminating the need for long-lived Access Keys.

Required GitHub Secrets
Add these to your repository settings (Settings > Secrets and variables > Actions):

Secret Name,Purpose
AWS_ROLE_ARN_DEV,IAM Role for Dev OIDC Auth
AWS_ROLE_ARN_STG,IAM Role for Stg OIDC Auth
AWS_ROLE_ARN_PROD,IAM Role for Prod OIDC Auth
NEW_RELIC_LICENSE_KEY,Ingest license for Java Agent
ECR_REPOSITORY_URL,AWS ECR URI (Output from Terraform)
INFRACOST_API_KEY,API key for cost estimation comments

Resource,Recommendation,Estimated Impact
ECS Fargate,Use Fargate Spot for non-prod environments.,~70% savings
NAT Gateway,Use VPC Endpoints (S3/ECR) to avoid data transfer fees.,Significant hourly savings
Architecture,Switch CPU/Memory to ARM64 (Graviton).,~20% better performance/$
Storage,Apply ECR Lifecycle policies to purge old images.,Reduces monthly storage waste

🔍 `Troubleshooting Guide`
New Relic Not Connecting: Check the container logs for com.newrelic INFO: Agent connected. Ensure the NEW_RELIC_LICENSE_KEY is not empty.

Health Check Failure: Verify the ALB is pinging /health on port 8080. If your app uses a different port, update the ALB target group in Terraform.

OIDC Auth Fails: Ensure the IAM Role's Trust Relationship correctly lists your GitHub Organization and Repository.

Terraform Locks: If you see "State Locked," check the DynamoDB table and use terraform force-unlock <id> if a previous process died unexpectedly.
