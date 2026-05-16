provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.60"
    }
  }
}



module "vpc" {
    source = "../../../modules/vpc"

    env = "develop"
    eks_name = "dev-eks-cluster"
    public_subnets = {
      "public-a" = {
        cidr = "10.0.0.0/19"
        az = "us-east-2a"
      },
      "public-b" = {
        cidr = "10.0.32.0/19"
        az = "us-east-2b"
      }
    }
    private_subnets = {
      "private-a" = {
        cidr = "10.0.64.0/19"
        az = "us-east-2a"
      },
      "private-b" = {
        cidr = "10.0.96.0/19"
        az = "us-east-2b"
      }
    }
}