locals {
    db_creds = jsondecode(
        data.aws_secretsmanager_secret_version.creds.secret_string
    )
}

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

module "postgresql" {
  source = "../../../../modules/database/postgresql"

  identifier  = "fastapi-postgres"
  db_name     = "fastapidb"
  db_username = local.db_creds.username
  db_password = local.db_creds.password

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  allowed_cidr_blocks = ["10.0.0.0/16"]
}