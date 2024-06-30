provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs      = "http://localhost:4566"
    sns      = "http://localhost:4566"
    lambda   = "http://localhost:4566"
  }
}
