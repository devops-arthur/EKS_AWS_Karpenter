resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  namespace  = "karpenter"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "clusterEndpoint"
    value = var.cluster_endpoint
  }
}

# Karpenter IAM role
resource "aws_iam_role" "karpenter_role" {
  name = "KarpenterRole-${var.cluster_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "eks.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "KarpenterRole-${var.cluster_name}"
  }
}


resource "aws_iam_role_policy_attachment" "karpenter_policies" {
  role       = aws_iam_role.karpenter_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

output "karpenter_role_arn" {
  value = aws_iam_role.karpenter_role.arn
}