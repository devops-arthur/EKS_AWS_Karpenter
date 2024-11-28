
output "vpc_values" {
  value = data.aws_vpc.vpc
}

output "subnet_values" {
  value = data.aws_subnets.subnets
}
