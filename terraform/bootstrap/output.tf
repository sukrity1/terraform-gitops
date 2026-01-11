output "s3_bucket_id" {
  description = "The name of the S3 bucket used for state storage"
  value       = aws_s3_bucket.tf_state.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.tf_state.arn
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for state locking"
  value       = aws_dynamodb_table.tf_lock.name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.tf_lock.arn
}