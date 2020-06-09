variable "AWS_REGION" {}
variable "AMIS"{
   type = map
   default = {
     "us-east-1" = "ami-085925f297f89fce1"
   }
}
variable "KEYPAIR_NAME" {}
variable "AWS_INSTANCE_TYPE" {}
variable "instance-security-group-id" {}
variable "NAME" {
  default = "autoscaling"
}
variable "private-subnets" {}
variable "rds_endpoint" {}
variable "DB_NAME" {}
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}

