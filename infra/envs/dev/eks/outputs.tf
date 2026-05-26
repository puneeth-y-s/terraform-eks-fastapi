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

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks.oidc_provider_url
}