terraform {
  backend "s3" {
    key = "java-api/terraform.tfstate"
  }
}

// terraform {
//   backend "s3" {
//     bucket         = "tf-state-dev"
//     key            = "java-api/terraform.tfstate"
//     region         = "us-east-1"
//     dynamodb_table = "tf-locks-dev"
//     encrypt        = true
//   }
// }