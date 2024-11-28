Overview

This repository automates the setup of an AWS EKS cluster with Karpenter for autoscaling. The cluster supports both x86 and ARM64 architectures using Graviton instances.

Prerequisites

	1.	AWS CLI and credentials configured.
	2.	Terraform installed.
	3.	Existing VPC ID.


1.Clone this repository:

2.Initialize and apply Terraform:
terraform init
terraform apply -var="vpc_id=your-vpc-id" -var="aws_region=your-region"

3.Configure kubectl:
aws eks update-kubeconfig --name <cluster_name> --region <region>


4.Deploy a pod on ARM64 or x86:
kubectl apply -f examples/pod-arm64.yaml
kubectl apply -f examples/pod-x86.yaml