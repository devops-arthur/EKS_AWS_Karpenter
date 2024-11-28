module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.eks_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_role_arn" {
  value = module.eks.cluster_iam_role_name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  provider = aws.us-west-1

  vpc_config {
    subnet_ids = concat(
      aws_subnet.private[*].id,
      aws_subnet.public[*].id
    )
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}
