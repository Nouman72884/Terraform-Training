data "terraform_remote_state" "vpc" {
  backend   = "s3"
  config = {
    bucket  = "s3lockstate"
    key     = "env:/dev/state"
    region  = "us-east-1"
  }
}
