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

resource "aws_s3_bucket" "terraform_state" {
    bucket = "dev-eks-cluster-terraform-state-1123581321"

    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state" {
  name         = "terraform-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform State Lock Table"
  }
}

terraform {
  backend "s3" {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "terraform-state"
    region = "us-east-2"
    encrypt = true
  }
}