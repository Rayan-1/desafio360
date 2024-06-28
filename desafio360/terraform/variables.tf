variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
  default     = "python"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
  default     = "meu-dynamodb"
}
