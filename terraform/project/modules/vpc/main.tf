data "aws_vpc" "nexus_vpc" {
  id = "vpc-0baab92eeab9e7971"  # ID da sua VPC
}


resource "aws_subnet" "sn_pub01" {
  vpc_id = data.aws_vpc.nexus_vpc.id
  cidr_block = "172.102.3.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "nexus-subnet-pub"
  }
}

resource "aws_internet_gateway" "nexus-igw" {
  vpc_id = data.aws_vpc.nexus_vpc.id
  tags = {
    Name = "nexus_igw" 
  }
}

resource "aws_route_table" "nexus-route_pub" {
  vpc_id = data.aws_vpc.nexus_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nexus-igw.id
  }
  tags = {
    Name = "nexus-routetable"
  }
}

resource "aws_route_table_association" "pub01assoc" {
  subnet_id = aws_subnet.sn_pub01.id
  route_table_id = aws_route_table.nexus-route_pub.id
}

