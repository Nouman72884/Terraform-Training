variable "AWS_REGION" {}
variable "AMIS"{
   type = map
   default = {
     "us-east-1" = "ami-085925f297f89fce1"
   }
}
variable "AWS_INSTANCE_TYPE" {}
variable "INSTANCE_NAME" {}
variable "KEYPAIR_NAME" {}
variable "private-subnet-1-id" {}
variable "vpc-id" {}
variable "instance-security-group-id" {}

