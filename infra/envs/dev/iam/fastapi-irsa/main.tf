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

module "fastapi_irsa" {
  source = "../../../../modules/iam/fastapi-irsa"

  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  oidc_provider_url = data.terraform_remote_state.eks.outputs.oidc_provider_url
}