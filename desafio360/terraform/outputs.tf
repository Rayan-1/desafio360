output "s3_bucket_name" {
  description = "O nome do bucket S3"
  value       = aws_s3_bucket.bucket.bucket
}

output "dynamodb_table_name" {
  description = "O nome da tabela DynamoDB"
  value       = aws_dynamodb_table.table.name
}

