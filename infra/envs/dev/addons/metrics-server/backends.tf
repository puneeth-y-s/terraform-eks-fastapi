terraform {
  backend "s3" {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key = "envs/dev/addons/metrics-server/terraform.tfstate"
    dynamodb_table = "terraform-state"
    region = "us-east-2"
    encrypt = true
  }
}