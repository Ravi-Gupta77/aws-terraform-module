# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "ravi" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
#  enable_dns_support   = "true"
  enable_dns_hostnames = true
#   enable_classiclink   = "false"

  tags = {
    Name = "ravi vpc"
  }

}

 
# Creating Public Subnets1 in VPC
resource "aws_subnet" "ravi-public-subnet1" {
  vpc_id                  = aws_vpc.ravi.id
  cidr_block              = "${var.public-subnet1}"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" 

  tags = {
    Name = "ravi public subnet1"
  }
}

# Creating Public Subnets2
resource "aws_subnet" "ravi-public-subnet2" {
  vpc_id                  = aws_vpc.ravi.id
  cidr_block              = "${var.public-subnet2}"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b" 

  tags = {
    Name = "ravi public subnet2"
  }
}

# Creating Private Subnets1 
resource "aws_subnet" "ravi-private-subnet1" {
  vpc_id                  = aws_vpc.ravi.id
  cidr_block              = "${var.private-subnet1}"
  map_public_ip_on_launch =  false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "ravi private subnet1"
  }
}

# Creating Private Subnets2 
resource "aws_subnet" "ravi-private-subnet2" {
  vpc_id                  = aws_vpc.ravi.id
  cidr_block              = "${var.private-subnet2}"
  map_public_ip_on_launch =  false
  availability_zone       = "us-east-1b"
  tags = {
    Name = "ravi private subnet2"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "ravi-igw" {
  vpc_id = aws_vpc.ravi.id

  tags = {
    Name = "ravi igw"
  }
}

#create Elastic IP for NAT gateway
resource "aws_eip" "ravi_eip"{
    # instance = aws_instance.ravi.id
    vpc = true
}

# Create NAT Gateways in public subnets
resource "aws_nat_gateway" "ravi-NAT" {
    allocation_id = aws_eip.ravi_eip.id
    subnet_id = aws_subnet.ravi-public-subnet1.id
    
    tags = {
    Name = "ravi NAT"
  }

  depends_on = [aws_internet_gateway.ravi-igw]
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.ravi.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ravi-igw.id
  }

  tags = {
    Name = "dev public igw"
  }
}

# Creating Route Associations public subnet1
resource "aws_route_table_association" "public-route-table1" {
  subnet_id      = aws_subnet.ravi-public-subnet1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-table2" {
  subnet_id      = aws_subnet.ravi-public-subnet2.id
  route_table_id = aws_route_table.public-route-table.id
}


# Creating EC2 instances in public subnets
# resource "aws_instance" "public_inst" {
#   ami = var.ami_id
#   instance_type = var.instance_type
#   subnet_id = "${aws_subnet.dev-public.id}"
#   key_name = "ravi-key"
#    root_block_device{
#     volume_size = 8
#     volume_type = "gp3"
#     encrypted = true
# }
#     tags = {
#     Name = "public_inst"
#   }
# } 
