###################
#   VPC MODULE    #
###################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = "openwebui-vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

#############################
#   Availability Zones Data  #
#############################
data "aws_availability_zones" "available" {
  state = "available"
}

###################
#   EKS MODULE    #
###################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.1.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  # ✅ Correct v20 syntax: use subnet_ids and vpc_id directly
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  # ✅ New name for node groups in v20+
  eks_managed_node_groups = {
    default = {
      desired_size   = var.node_group_desired_capacity
      min_size       = 1
      max_size       = 3
      instance_types = [var.node_instance_type]
    }
  }

  tags = {
    Project = "open-webui-ollama"
  }
}
