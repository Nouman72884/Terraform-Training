# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}


# Internet VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${terraform.workspace}-${var.NAME}"
  }
}

# Subnets
resource "aws_subnet" "public-subnets" {
  count = length(var.PUBLIC_SUBNET)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_SUBNET[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${terraform.workspace}-${var.NAME}-public-subnet-${count.index}"
  }
}


resource "aws_subnet" "private-subnets" {
  count = length(var.PRIVATE_SUBNET)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRIVATE_SUBNET[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${terraform.workspace}-${var.NAME}-private-subnet-${count.index}"
  }
}

# Internet GW
resource "aws_internet_gateway" "vpc-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${terraform.workspace}-${var.NAME}-gw"
  }
}

# route tables
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-gw.id
  }

  tags = {
    Name = "${terraform.workspace}-${var.NAME}-public-route-table"
  }
}

# route associations public
resource "aws_route_table_association" "public-subnets" {
  count = length(var.PUBLIC_SUBNET)
  subnet_id      =  aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}

