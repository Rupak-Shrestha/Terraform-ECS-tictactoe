# VPC Configuration

# Create an AWS VPC with the specified CIDR block
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr  # Set the CIDR block for the VPC

  tags = {
    name = "main"  # Tag the VPC with a name
  }
}

# Subnet Configuration

# Create a subnet within the VPC
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id  # Associate the subnet with the VPC
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)  # Define the subnet CIDR block
  map_public_ip_on_launch = true  # Enable automatic assignment of public IP addresses
  availability_zone       = var.availability_zones  # Specify the availability zone for the subnet
}

# Internet Gateway Configuration

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  # Attach the Internet Gateway to the VPC

  tags = {
    Name = "igw"  # Tag the Internet Gateway with a name
  }
}

# Route Table Configuration

# Create a route table and associate it with the VPC
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id  # Associate the route table with the VPC

  # Define a default route to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"  # Destination CIDR block
    gateway_id = aws_internet_gateway.igw.id  # Target gateway (Internet Gateway)
  }
}

# Associate the subnet with the route table
resource "aws_route_table_association" "subnet_route" {
  subnet_id      = aws_subnet.subnet.id  # Associate the subnet with the route table
  route_table_id = aws_route_table.rt.id  # Specify the route table to associate with the subnet
}
