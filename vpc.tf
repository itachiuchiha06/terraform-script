# update provider
# AWS as my provider

# VPC

resource "aws_vpc" "ram" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "RAM"
  }
}

# Private Subnet
resource "aws_subnet" "ram_pvt_sun" {
  vpc_id                  = aws_vpc.ram.id
  cidr_block              = var.pvtsubnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "RAM_PVT_SUN"
  }
}

# Public Subnet
resource "aws_subnet" "ram_pub_sun" {
  vpc_id                  = aws_vpc.ram.id
  cidr_block              = var.pubsubnet_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "RAM_PUB_SUN"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ram_igw" {
  vpc_id = aws_vpc.ram.id

  tags = {
    Name = "RAM_IGW"
  }
}

output "aws_internet_gateway_ids" {
  value = aws_internet_gateway.ram_igw.id
}

# Public route table
resource "aws_route_table" "ram_pub_rt" {
  vpc_id = aws_vpc.ram.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ram_igw.id
  }
  tags = {
    Name = "RAM_PUB_RT"
  }
}

output "aws_public_route_table_ids" {
  value = aws_route_table.ram_pub_rt.id
}

# Private route table
resource "aws_route_table" "ram_pvt_rt" {
  vpc_id = aws_vpc.ram.id

  tags = {
    Name = "RAM_PVT_RT"
  }
}

output "aws_private_route_table_ids" {
  value = aws_route_table.ram_pvt_rt.id
}

# Routable association
resource "aws_route_table_association" "ram_pub_rt" {
  subnet_id      = aws_subnet.ram_pub_sun.id
  route_table_id = aws_route_table.ram_pub_rt.id
}

# Routable association
resource "aws_route_table_association" "ram_pvt_rt" {
  subnet_id      = aws_subnet.ram_pvt_sun.id
  route_table_id = aws_route_table.ram_pvt_rt.id
}
