module "vpc" {
  source = "./modules/vpc"
  AWS_REGION     = var.AWS_REGION
  VPC_CIDR = var.VPC_CIDR
  PUBLIC_SUBNET = var.PUBLIC_SUBNET
  PRIVATE_SUBNET = var.PRIVATE_SUBNET
  VPC_MODULE_NAME = var.VPC_MODULE_NAME
}
module "ec2-instance" {
  source = "./modules/ec2-instance"
  private-subnet-1-id = module.vpc.private-subnet-1-id
  vpc-id = module.vpc.vpc-id
  instance-security-group-id = module.vpc.instance-security-group-id
  KEYPAIR_NAME = var.KEYPAIR_NAME
  AWS_REGION     = var.AWS_REGION
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
  EC2_MODULE_NAME = var.EC2_MODULE_NAME
}
