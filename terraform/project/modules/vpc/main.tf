data "aws_vpc" "sidral_vpc" {
  id = "vpc-0bec9b838f67e4b57"  # ID da sua VPC
}


resource "aws_subnet" "sidral-sn_pub01" {
  vpc_id = data.aws_vpc.sidral_vpc.id
  cidr_block = "172.102.1.0/24"
  availability_zone = "us-west-1b"
  tags = {
    Name = "sidral-sn-pub01"
  }
}


resource "aws_internet_gateway" "sidral-igw" {
  vpc_id = data.aws_vpc.sidral_vpc.id
  tags = {
    Name = "sidral_igw" 
  }
}

resource "aws_route_table" "sidral-route_pub" {
  vpc_id = data.aws_vpc.sidral_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sidral-igw.id
  }
  tags = {
    Name = "sidral-routetable"
  }
}

resource "aws_route_table_association" "pub01assoc" {
  subnet_id = aws_subnet.sidral-sn_pub01.id
  route_table_id = aws_route_table.sidral-route_pub.id
}

