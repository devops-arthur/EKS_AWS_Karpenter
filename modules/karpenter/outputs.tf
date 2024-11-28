output "instance_role_arn" {
  value = aws_iam_role.karpenter_role.arn
}