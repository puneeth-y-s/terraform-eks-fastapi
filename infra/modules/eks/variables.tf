variable "env" {
  type = string
  description = "The Name of the environment."
}

variable "eks_name" {
  type = string
  description = "The Name of the eks cluster."
}

variable "eks_version" {
    type = string
    description = "The version of the EKS."
}

variable "private_subnet_ids" {
    type = list(string)
    description = "The List of private subnet ids."
}