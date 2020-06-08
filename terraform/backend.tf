terraform {
  backend "s3" {
    bucket         = "bucketname"
    key            = "state"
    encrypt        = true
    region         = "us-east-1"
    dynamodb_table = "tablename"
  }
}
