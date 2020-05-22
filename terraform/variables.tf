variable "AWS_REGION" {}
variable "AMIS" {
  type = map
  default = {
    "us-east-1" = "ami-085925f297f89fce1"
  }
}
variable "AWS_INSTANCE_TYPE" {}
variable "KEYPAIR_NAME" {}
variable "VPC_CIDR" {}
variable "PUBLIC_SUBNET" {}
variable "PRIVATE_SUBNET" {}
