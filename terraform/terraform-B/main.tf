module "alb" {
  source = "./modules/alb"
  vpc-id = data.terraform_remote_state.vpc.outputs.vpc-id
  alb-security-group-id = data.terraform_remote_state.vpc.outputs.alb-security-group-id
  public-subnets = data.terraform_remote_state.vpc.outputs.public-subnets
  autoscaling-group-id = module.autoscaling.autoscaling-group-id
}
module "autoscaling" {
  source = "./modules/autoscaling"
  KEYPAIR_NAME = var.KEYPAIR_NAME
  AWS_REGION     = var.AWS_REGION
  AWS_INSTANCE_TYPE = var.AWS_INSTANCE_TYPE
  instance-security-group-id = data.terraform_remote_state.vpc.outputs.instance-security-group-id
  private-subnets = data.terraform_remote_state.vpc.outputs.private-subnets
  rds_endpoint = module.db.rds_endpoint
  DB_NAME = var.DB_NAME
  RDS_USERNAME = var.RDS_USERNAME
  RDS_PASSWORD = var.RDS_PASSWORD
}
module "db" {
  source = "./modules/db"
  db-security-group-id = data.terraform_remote_state.vpc.outputs.db-security-group-id
  DB_NAME = var.DB_NAME
  RDS_PASSWORD = var.RDS_PASSWORD
  RDS_USERNAME = var.RDS_USERNAME
  private-subnet-id-1 = data.terraform_remote_state.vpc.outputs.private-subnet-id-1
  private-subnet-id-2 = data.terraform_remote_state.vpc.outputs.private-subnet-id-2
}

