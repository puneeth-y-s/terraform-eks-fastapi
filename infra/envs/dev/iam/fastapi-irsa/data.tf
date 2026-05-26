data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key    = "envs/dev/eks/terraform.tfstate"
    region = "us-east-2"
  }
}
