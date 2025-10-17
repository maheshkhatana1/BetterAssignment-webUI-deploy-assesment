terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # lock to 5.x for compatibility
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

#############################################
# AWS Provider
#############################################
provider "aws" {
  region = var.aws_region
}

#############################################
# Kubernetes Provider (AFTER EKS is created)
#############################################
# Use alias so Terraform doesn't try to connect before cluster exists
provider "kubernetes" {
  alias                  = "eks"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = module.eks.cluster_token
}

#############################################
# Optional AWS identity (for debugging/info)
#############################################
data "aws_caller_identity" "current" {}
