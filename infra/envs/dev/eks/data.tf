data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key    = "envs/dev/vpc/terraform.tfstate"
    region = "us-east-2"
  }
}