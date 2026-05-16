output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "endpoint" {
  value = module.eks.endpoint
}

output "ca" {
  value = module.eks.ca
  sensitive = true
}