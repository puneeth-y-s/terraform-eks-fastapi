variable "eks_cluster_name" {
  type = string
  description = "The Name of the EKS Cluster."
  default = "dev-eks-cluster"
}

variable "aws_region" {
    type = string
    description = "The region to deploy aws resources."
    default = "us-east-2"
}