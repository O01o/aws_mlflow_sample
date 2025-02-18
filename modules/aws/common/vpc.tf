locals {
  az_first = "${var.region}${var.az.first}"
  az_second = "${var.region}${var.az.second}"

  ip_addr_zero = "0.0.0.0/0"
  ip_addr_vpc = "10.0.0.0/16"
  ip_addr_subent_1 = "10.0.1.0/24"
  ip_addr_subent_2 = "10.0.2.0/24"
  ip_addr_subent_3 = "10.0.3.0/24"
}


# ------------------------------------------------------
# VPC Common Resources
# ------------------------------------------------------

resource "aws_vpc" "vpc" {
    cidr_block = local.ip_addr_vpc
    instance_tenancy = "default"

    tags = {
      Name = "${var.name}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "${var.name}-igw"
  }
}


# ------------------------------------------------------
# VPC NAT Gateway
# ------------------------------------------------------

resource "aws_eip" "ngw_eip" {

  tags = {
    Name = "${var.name}-ngw-eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.allocation_id
  subnet_id = aws_subnet.public01.id

  tags = {
    Name = "${var.name}-ngw"
  }
}


# ------------------------------------------------------
# VPC Subnets
# ------------------------------------------------------

resource "aws_subnet" "public01" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.az_first
  cidr_block = local.ip_addr_subent_3

  tags = {
    Name = "${var.name}-public01"
  }
}

resource "aws_subnet" "private01" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.az_first
  cidr_block = local.ip_addr_subent_1

  tags = {
    Name = "${var.name}-private01"
  }
}

resource "aws_subnet" "private02" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = local.az_first
  cidr_block = local.ip_addr_subent_2

  tags = {
    Name = "${var.name}-private02"
  }
}


# ------------------------------------------------------
# VPC Route Tables
# ------------------------------------------------------

resource "aws_route_table" "rtb00" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-rtb00"
  }
}

resource "aws_route_table" "rtb01" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-rtb01"
  }
}


# ------------------------------------------------------
# VPC Routes (between Route Table and Gateway)
# ------------------------------------------------------

resource "aws_route" "r-rtb00_igw" {
  route_table_id = aws_route_table.rtb00.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = local.ip_addr_zero
}

resource "aws_route" "r-rtb01_ngw" {
  route_table_id         = aws_route_table.rtb01.id
  nat_gateway_id         = aws_nat_gateway.ngw.id
  destination_cidr_block = local.ip_addr_zero
}


# ------------------------------------------------------
# VPC Route Table Associations (between Route Table and Subnet)
# ------------------------------------------------------

resource "aws_route_table_association" "rta_rtb01_private01" {
  route_table_id = aws_route_table.rtb01.id
  subnet_id = aws_subnet.private01.id
}

resource "aws_route_table_association" "rta_rtb01_private02" {
  route_table_id = aws_route_table.rtb01.id
  subnet_id = aws_subnet.private02.id
}

resource "aws_route_table_association" "rta_rtb00_public01" {
  route_table_id = aws_route_table.rtb00.id
  subnet_id = aws_subnet.public01.id
}