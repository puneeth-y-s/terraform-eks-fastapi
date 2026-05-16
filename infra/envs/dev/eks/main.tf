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

module "eks" {
  source = "../../../modules/eks"

  env = "develop"
  eks_name = "dev-eks-cluster"
  eks_version = "1.30"
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}