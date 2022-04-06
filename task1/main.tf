## Main config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
 required_version = ">= 1.1.7"
}


provider "aws" {
  region = "eu-central-1"
}


## Data sources
data "aws_vpcs" "vpc" {}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpc.ids
  }
}

data "aws_security_groups" "sg" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpc.ids
  }
}
