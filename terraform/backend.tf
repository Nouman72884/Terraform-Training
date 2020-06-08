terraform {
  backend "s3" {
    bucket         = "lockstate"
    key            = "state"
    encrypt        = true
    region         = "us-east-1"
    dynamodb_table = "lockstate"
  }
}

