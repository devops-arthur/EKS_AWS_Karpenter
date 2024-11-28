data "aws_vpc" "vpc" {
  id = "vpc-0bc2b1c7fafca5c23"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0bc2b1c7fafca5c23"]
  }
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "subnet_ids" {
  value = data.aws_subnets.subnets.ids
}
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = "vpc-0bc2b1c7fafca5c23"
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]  # Use us-east-1a and us-east-1b

  tags = {
    Name                              = "private-${var.azs[count.index]}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = "vpc-0bc2b1c7fafca5c23"
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]  # Use us-east-1a and us-east-1b

  tags = {
    Name                              = "public-${var.azs[count.index]}"
    "kubernetes.io/role/elb"          = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}