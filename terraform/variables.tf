variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}
variable "AMIS" {
  type = map
  default = {
    "us-east-1" = "ami-085925f297f89fce1"
  }
}
variable "AWS_INSTANCE_TYPE" {}
variable "INSTANCE_NAME" {}
variable "KEYPAIR_NAME" {}
variable "SECURITY_GROUP_NAME" {}
variable "VPC_CIDR" {}
variable "PUBLIC_SUBNET_1_CIDR" {}
variable "PUBLIC_SUBNET_2_CIDR" {}
variable "PRIVATE_SUBNET_1_CIDR" {}
variable "PRIVATE_SUBNET_2_CIDR" {}

