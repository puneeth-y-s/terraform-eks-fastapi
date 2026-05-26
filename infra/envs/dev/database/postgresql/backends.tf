terraform {
  backend "s3" {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key = "envs/dev/database/postgresql/terraform.tfstate"
    dynamodb_table = "terraform-state"
    region = "us-east-2"
    encrypt = true
  }
}