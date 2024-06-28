provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5TMRIY2QL3Z2Y4KQ"
  secret_key = "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"

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs      = "http://localhost:4566"
    sns      = "http://localhost:4566"
    lambda   = "http://localhost:4566"
  }
}
