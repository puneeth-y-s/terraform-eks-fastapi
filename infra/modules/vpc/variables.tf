variable "env" {
  type = string
  description = "The Name of the environment."
}

variable "eks_name" {
  type = string
  description = "The Name of the eks cluster."
}

variable "cidr" {
  type = string
  description = "The IPv4 CIDR block for the VPC."
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets configuration"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Private subnets configuration"

  type = map(object({
    cidr = string
    az   = string
  }))
}