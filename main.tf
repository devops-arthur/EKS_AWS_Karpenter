
module "vpc" {
  source = "./modules/vpc"
  vpc_id = var.vpc_id
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
  eks_version  = var.eks_version
}

module "karpenter" {
  source           = "./modules/karpenter"
  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  subnet_ids       = module.vpc.subnet_ids
}