
# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet-1.id
  depends_on    = [aws_internet_gateway.vpc-gw]
  tags = {
    Name = "${terraform.workspace}-${var.VPC_MODULE_NAME}-nat-gw"
}
}
# VPC setup for NAT
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "${terraform.workspace}-${var.VPC_MODULE_NAME}-private-route-table"
  }
}

# route associations private
resource "aws_route_table_association" "private-subnet-1-a" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-2-b" {
  subnet_id      = aws_subnet.private-subnet-2.id

# route associations private
resource "aws_route_table_association" "private-subnets" {
  count = length(var.PRIVATE_SUBNET)
  subnet_id      =  aws_subnet.private-subnets[count.index].id

  route_table_id = aws_route_table.private-route-table.id
}

