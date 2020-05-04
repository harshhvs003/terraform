#vpc cidr
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo-vpc"
  }
}

#igw
resource "aws_internet_gateway" "demo_vpc_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo_vpc"
  }
}


#publicsubnet
resource "aws_subnet" "demo_vpc_public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.public_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_vpc_public_subnet"
  }
}

#private subnet
resource "aws_subnet" "demo_vpc_private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.private_cidr

  tags = {
    Name = "demo_vpc_private_subnet"
  }
}
 

#public route table
resource "aws_route_table" "demo_vpc_public_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_vpc_igw.id
  }
  tags = {
    Name = "demo_vpc_public_rt"
  }
}

#route table association
resource "aws_route_table_association" "demo_vpc_rta" {
  subnet_id      = aws_subnet.demo_vpc_public_subnet.id
  route_table_id = aws_route_table.demo_vpc_public_rt.id
}

