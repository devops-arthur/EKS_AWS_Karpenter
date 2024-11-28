variable "cluster_name" {
  type    = string
  default = "karpenter-eks"
}

variable "eks_version" {
  type    = string
  default = "1.27"
}

variable "vpc_id" {
  type = string
}
variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]  # Using supported AZs
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Adjust these according to your VPC CIDR
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]  # Adjust these according to your VPC CIDR
}
variable "subnet_ids" {
  type = list(string)
}