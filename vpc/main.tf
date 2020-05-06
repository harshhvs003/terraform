data "aws_availability_zones" "azs" {
}





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
  count = length(var.public_cidr)
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = element(var.public_cidr,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_vpc_public_subnet ${element(data.aws_availability_zones.azs.names,count.index)}"

  }
}

#private subnet
resource "aws_subnet" "demo_vpc_private_subnet" {
  count = length(var.private_cidr)
  vpc_id     = aws_vpc.demo_vpc.id
  availability_zone = element(data.aws_availability_zones.azs.names,count.index)
  cidr_block = element(var.private_cidr,count.index)


  tags = {
    Name = "demo_vpc_private_subnet ${element(data.aws_availability_zones.azs.names,count.index)}"
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
  count =  length(var.public_cidr)
  subnet_id      = aws_subnet.demo_vpc_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.demo_vpc_public_rt.id
}

