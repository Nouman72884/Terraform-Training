module "vpc" {
  source = "./modules/vpc"
  AWS_REGION     = var.AWS_REGION
  VPC_CIDR = var.VPC_CIDR
  PUBLIC_SUBNET = var.PUBLIC_SUBNET
  PRIVATE_SUBNET = var.PRIVATE_SUBNET
}
module "ec2-instance" {
  source = "./modules/ec2-instance"
  private-subnets-id = module.vpc.private-subnets-id
  vpc-id = module.vpc.vpc-id
  instance-security-group-id = module.vpc.instance-security-group-id
  KEYPAIR_NAME = var.KEYPAIR_NAME
  AWS_REGION     = var.AWS_REGION
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
}

