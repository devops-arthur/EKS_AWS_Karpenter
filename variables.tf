variable "aws_region" {
  description = "AWS Region to deploy the EKS cluster"
  type        = string
  default     = "us-west-1"
}

variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "saturn-eks-cluster"
}

variable "eks_version" {
  description = "The Kubernetes version for EKS"
  type        = string
  default     = "1.27"
}