module "vpc" {
  source = "./modules/vpc"
  AWS_REGION     = var.AWS_REGION
  VPC_CIDR = var.VPC_CIDR
  PUBLIC_SUBNET = var.PUBLIC_SUBNET
  PRIVATE_SUBNET = var.PRIVATE_SUBNET
}
module "alb" {
  source = "./modules/alb"
  vpc-id = module.vpc.vpc-id
  alb-security-group-id = module.vpc.alb-security-group-id
  public-subnets = module.vpc.public-subnets
  autoscaling-group-id = module.autoscaling.autoscaling-group-id
}
module "autoscaling" {
  source = "./modules/autoscaling"
  KEYPAIR_NAME = var.KEYPAIR_NAME
  AWS_REGION     = var.AWS_REGION
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
  instance-security-group-id = module.vpc.instance-security-group-id
  private-subnets = module.vpc.private-subnets
  rds_endpoint = module.db.rds_endpoint
  DB_NAME = var.DB_NAME
  RDS_USERNAME = var.RDS_USERNAME
  RDS_PASSWORD = var.RDS_PASSWORD
}
module "db" {
  source = "./modules/db"
  db-security-group-id = module.vpc.db-security-group-id
  DB_NAME = var.DB_NAME
  RDS_PASSWORD = var.RDS_PASSWORD
  RDS_USERNAME = var.RDS_USERNAME
  private-subnet-id-1 = module.vpc.private-subnet-id-1
  private-subnet-id-2 = module.vpc.private-subnet-id-2
}

