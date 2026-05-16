data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "dev-eks-cluster-terraform-state-1123581321"
    key    = "envs/dev/eks/terraform.tfstate"
    region = "us-east-2"
  }
}

data "aws_eks_cluster_auth" "eks" {
    name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}