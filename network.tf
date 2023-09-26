#######################-Create VPC-#######################
resource "aws_vpc" "cloud_storage_vpc" {
  cidr_block = "10.240.0.0/16" # Replace with your desired CIDR block
  tags = {
    Name = "VPC-${var.project}"
  }
}

#######################-Create Public subnet-#######################
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.cloud_storage_vpc.id
  cidr_block        = "10.240.1.0/26" # Replace with your desired CIDR block
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "Public-Subnet-a"
  }
}

#######################-Create Public subnet-#######################

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.cloud_storage_vpc.id
  cidr_block        = "10.240.1.64/26" # Replace with your desired CIDR block
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "Public-Subnet-b"
  }
}

#######################-Create internet gateway-#######################
resource "aws_internet_gateway" "cloud_storage_igw" {
  vpc_id = aws_vpc.cloud_storage_vpc.id
  tags = {
    Name = "internet-gateway"
  }
}

#######################-Create Public route table-#######################
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.cloud_storage_vpc.id
  tags = {
    Name = "public-route-table"
  }
}

#######################-Connect Public RTB vs IGW-#######################
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cloud_storage_igw.id
}

#######################-Allocate Route table with Public subnet-#######################
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rtb.id
}

#######################-Allocate Route table with Public subnet-#######################
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rtb.id
}


