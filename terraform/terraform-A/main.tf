module "vpc" {
  source = "./modules/vpc"
  AWS_REGION     = var.AWS_REGION
  VPC_CIDR = var.VPC_CIDR
  PUBLIC_SUBNET = var.PUBLIC_SUBNET
  PRIVATE_SUBNET = var.PRIVATE_SUBNET
}
