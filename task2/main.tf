## Main config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
  backend "s3" {
    bucket  = "tf-state-task2"
    encrypt = true
    key     = "terraform.tfstate"
    region  = "eu-central-1"
  }
 required_version = ">= 1.1.7"
}


provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Owner = "andrei_scheglov@epam.com"
      Project = "Terraform_task2"
    }
  }
}


# AZ
data "aws_availability_zones" "available" { }

# Last ami
data "aws_ami" "last_amazon"{
  owners = ["137112412989"]
  most_recent = true
  filter{
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}


# Create VPC
resource "aws_vpc" "vcp" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "VPC" })
}

## Create Subnets
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vcp.id
  cidr_block        = "192.168.100.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(var.tags, { Name = "Subnet in ${data.aws_availability_zones.available.names[0]}" })
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.vcp.id
  cidr_block        = "192.168.200.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = merge(var.tags, { Name = "Subnet in ${data.aws_availability_zones.available.names[1]}" })
}

## Create Internet Gateway for WP_VPC
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vcp.id
  tags = merge(var.tags, { Name = "Internet Gateway" })
  depends_on = [aws_vpc.vcp]
}

## Route to Internet Gateway
resource "aws_route" "route_to_gateway" {
  route_table_id         = aws_vpc.vcp.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
  depends_on             = [aws_internet_gateway.gateway, aws_vpc.vcp]
}

## Create route association
resource "aws_route_table_association" "subnet-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_vpc.vcp.main_route_table_id
}

resource "aws_route_table_association" "subnet-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_vpc.vcp.main_route_table_id
}



# Create Security Groups
## For EC2 Instances 80
resource "aws_security_group" "sg_ec2" {
  name        = "SG_for_EC2"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.vcp.id
  ingress {
    description = "Allow all inbound traffic on the 80 port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "SG for EC2" })
}

# For RDS MySQL
resource "aws_security_group" "sg_rds" {
  name        = "SG_for_RDS"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.vcp.id
  ingress {
    description     = "RDS from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "RDS from EC2" })
  depends_on = [aws_security_group.sg_ec2]
}

# Create EC-2 instance with nginx via module
module "nginx" {
  source        = "./modules/nginx"
  ec2_ami       = data.aws_ami.last_amazon.id
  subnet        = aws_subnet.subnet-1.id
  sg            = [aws_security_group.sg_ec2.id]
  instance_type = var.instance_type
}

# Create DB instance via module
module "rds" {
  source        = "./modules/rds"
  subnets       = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  sg            = [aws_security_group.sg_rds.id]
  instance_type = "db.t2.micro"
}