data "aws_availability_zones" "azs" {}

locals {
  azs = slice(data.aws_availability_zones.azs.names, 0, 2)
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name="${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = local.azs[0]

  map_public_ip_on_launch = true

  tags = {
    Name="${var.env_prefix}-subnet-public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = local.azs[0]

  map_public_ip_on_launch = false

  tags = {
    Name="${var.env_prefix}-subnet-private"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_2
  availability_zone = local.azs[1]

  map_public_ip_on_launch = false

  tags = {
    Name="${var.env_prefix}-subnet-private-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name="${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name="${var.env_prefix}-rtb"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet-2.id]
  name = "${var.env_prefix}-rds-subnet-group"
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}
