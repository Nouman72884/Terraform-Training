output "vpc-id"{
  value = aws_vpc.vpc.id
}
output "public-subnets" {

  value = aws_subnet.public-subnets.*.id

  value = "${join(",", aws_subnet.public-subnets.*.id)}"

}
output "private-subnets" {
  value = "${join(",", aws_subnet.private-subnets.*.id)}"
}
output "instance-security-group-id" {
  value = aws_security_group.instance-security-group.id
}

output "alb-security-group-id" {
  value = aws_security_group.alb-security-group.id
}
output "db-security-group-id" {
  value = aws_security_group.db-security-group.id
}
output "private-subnets-id" {
  value = "${aws_subnet.private-subnets[0].id}"
}
output "public-subnet-id-1" {
  value = "${aws_subnet.public-subnets[0].id}"
}
output "public-subnet-id-2" {
  value = "${aws_subnet.public-subnets[1].id}"
}

output "private-subnets-id" {
  value = "${aws_subnet.private-subnets[0].id}"
}

