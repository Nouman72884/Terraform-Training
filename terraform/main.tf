module "vpc" {
  source                = "./modules/vpc"
  AWS_REGION            = var.AWS_REGION
  VPC_CIDR              = var.VPC_CIDR
  PUBLIC_SUBNET_1_CIDR  = var.PUBLIC_SUBNET_1_CIDR
  PUBLIC_SUBNET_2_CIDR  = var.PUBLIC_SUBNET_2_CIDR
  PRIVATE_SUBNET_1_CIDR = var.PRIVATE_SUBNET_1_CIDR
  PRIVATE_SUBNET_2_CIDR = var.PRIVATE_SUBNET_2_CIDR
  SECURITY_GROUP_NAME   = var.SECURITY_GROUP_NAME
}
module "ec2-instance" {
  source                     = "./modules/ec2-instance"
  private-subnet-1-id        = module.vpc.private-subnet-1-id
  vpc-id                     = module.vpc.vpc-id
  instance-security-group-id = module.vpc.instance-security-group-id
  INSTANCE_NAME              = var.INSTANCE_NAME
  KEYPAIR_NAME               = var.KEYPAIR_NAME
  AWS_REGION                 = var.AWS_REGION
  AWS_INSTANCE_TYPE          = var.AWS_INSTANCE_TYPE
}

