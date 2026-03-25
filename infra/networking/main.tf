variable "vcp_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "availability_zone" {}
variable "cidr_private_subnet" {}

output "dev_proj1_vpc_id" {
  value = aws_vpc.dev_proj1_vpc_us_east_1.id
}

output "dev_proj1_public_subnets" {
  value = aws_subnet.dev_proj1_public_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.dev_proj1_public_subnets.*.cidr_block
}



# Setup VPC
resource "aws_vpc" "dev_proj1_vpc_us_east_1" {
  cidr_block = var.vcp_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Set Public subnet
resource "aws_subnet" "dev_proj1_public_subnets" {
  vpc_id = aws_vpc.dev_proj1_vpc_us_east_1.id
  count = length(var.cidr_public_subnet)
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "dev-proj1-public-subnet-${count.index+1}"
  }
}

# Set Private subnet
resource "aws_subnet" "dev_proj1_private_subnets" {
  vpc_id = aws_vpc.dev_proj1_vpc_us_east_1.id
  count = length(var.cidr_private_subnet)
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "dev-proj1-private-subnet-${count.index+1}"
  }
}



# Set Internet Gateway
resource "aws_internet_gateway" "dev_proj1_public_internet_gateway" {
  vpc_id = aws_vpc.dev_proj1_vpc_us_east_1.id
  tags = {
    Name = "dev-proj1-IGW"
  }
}

# Route Table - Public
resource "aws_route_table" "dev_proj1_public_route_table" {
  vpc_id = aws_vpc.dev_proj1_vpc_us_east_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_proj1_public_internet_gateway.id
  }

  tags = {
    Name = "dev-proj1-public-rt"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "dev_proj1_public_rt_subnet_association" {
  route_table_id = aws_route_table.dev_proj1_public_route_table.id
  count = length(aws_subnet.dev_proj1_public_subnets)
  subnet_id = aws_subnet.dev_proj1_public_subnets[count.index].id
}

#  Route Table - Private
resource "aws_route_table" "dev_proj1_private_subnets" {
  vpc_id = aws_vpc.dev_proj1_vpc_us_east_1.id
  tags = {
    Name = "dev-proj1-private-rt"
  }
}

resource "aws_route_table_association" "dev_proj1_private_rt_subnet_association" {
  route_table_id = aws_route_table.dev_proj1_private_subnets.id
  count = length(aws_subnet.dev_proj1_private_subnets)
  subnet_id = aws_subnet.dev_proj1_private_subnets[count.index].id
}
