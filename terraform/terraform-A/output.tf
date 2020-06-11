output "vpc-id" {
  value = module.vpc.vpc-id
}
output "public-subnets" {
  value = module.vpc.public-subnets
}
output "private-subnets" {
  value = module.vpc.private-subnets
}
output "instance-security-group-id" {
  value = module.vpc.instance-security-group-id
}
output "alb-security-group-id" {
  value = module.vpc.alb-security-group-id
}
output "db-security-group-id" {
  value = module.vpc.db-security-group-id
}
output "private-subnet-id-1" {
  value = module.vpc.private-subnet-id-1
}
output "private-subnet-id-2" {
  value = module.vpc.private-subnet-id-2
}

