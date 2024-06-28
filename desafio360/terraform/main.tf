resource "aws_s3_bucket" "bucket" {
  bucket = "python"
}

resource "aws_dynamodb_table" "table" {
  name           = "meu-dynamodb"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
