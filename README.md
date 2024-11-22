# EKS Cluster with Karpenter and Graviton Instances

This repository automates the deployment of an AWS EKS cluster integrated with Karpenter for autoscaling. The setup supports mixed architectures (x86 and ARM64 via Graviton instances).

## Prerequisites

Before proceeding, ensure the following:

1. **AWS CLI** is installed and configured with credentials:
   ```bash
   aws configure
   ```
2. **Terraform** is installed. [Download Terraform](https://www.terraform.io/downloads.html).
3. An **existing VPC** in AWS with subnet IDs (you will need the VPC ID).

---

## Directory Structure

```
eks-karpenter-terraform/
├── main.tf              # Top-level Terraform configuration
├── variables.tf         # Terraform input variables
├── outputs.tf           # Terraform outputs
├── modules/             # Modularized Terraform configurations
│   ├── eks/             # EKS cluster module
│   ├── karpenter/       # Karpenter module
│   └── vpc/             # Existing VPC module
├── examples/            # Workload deployment examples
│   ├── pod-arm64.yaml   # ARM64 pod example
│   ├── pod-x86.yaml     # x86 pod example
└── README.md            # This file
```

---

## Deployment Instructions

Follow these steps to deploy the EKS cluster and Karpenter.

### Step 1: Clone the Repository
```bash
git clone https://github.com/your-org/eks-karpenter-terraform.git
cd eks-karpenter-terraform
```

### Step 2: Initialize Terraform
Run the following command to initialize the Terraform project:
```bash
terraform init
```

### Step 3: Deploy the Infrastructure
Apply the Terraform configuration to create the EKS cluster and deploy Karpenter:
```bash
terraform apply -var="vpc_id=<your-vpc-id>" -var="aws_region=<your-region>"
```

**Required Variables**:
- `vpc_id`: The ID of your existing VPC.
- `aws_region`: The AWS region where the infrastructure will be deployed.

Example:
```bash
terraform apply -var="vpc_id=vpc-0a1b2c3d4e5f6g7h8" -var="aws_region=us-east-1"
```

### Step 4: Configure kubectl
Once the infrastructure is deployed, configure your local kubectl to connect to the EKS cluster:
```bash
aws eks update-kubeconfig --name <cluster_name> --region <aws_region>
```

Example:
```bash
aws eks update-kubeconfig --name karpenter-eks --region us-east-1
```

### Step 5: Verify the Cluster
Check that the cluster is running:
```bash
kubectl get nodes
```

---

## Deploying Workloads on x86 or ARM64

Developers can deploy workloads targeting specific architectures using the provided examples.

### Deploy a Pod on ARM64
To deploy a pod on an ARM64 Graviton instance, run:
```bash
kubectl apply -f examples/pod-arm64.yaml
```

#### `examples/pod-arm64.yaml`
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-arm64
spec:
  nodeSelector:
    kubernetes.io/arch: arm64
  containers:
    - name: nginx
      image: nginx
```

### Deploy a Pod on x86
To deploy a pod on an x86 instance, run:
```bash
kubectl apply -f examples/pod-x86.yaml
```

#### `examples/pod-x86.yaml`
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-x86
spec:
  nodeSelector:
    kubernetes.io/arch: amd64
  containers:
    - name: nginx
      image: nginx
```

---

## How to Clean Up

To destroy the infrastructure and clean up all resources:
```bash
terraform destroy -var="vpc_id=<your-vpc-id>" -var="aws_region=<your-region>"
```

---

## FAQ

### What is Karpenter?
Karpenter is a Kubernetes cluster autoscaler that automatically provisions and deprovisions nodes in response to dynamic workloads. It enables fine-grained control over instance types, architectures, and scaling policies.

### How do I modify instance types or limits?
Edit the provisioners in the `modules/karpenter/templates/` directory:
- `karpenter-provisioner-arm64.yaml`
- `karpenter-provisioner-x86.yaml`

Update the CPU limits, instance types, or other configurations as needed.

### How do I debug a workload that doesn't start?
Check the node selector labels in your pod's YAML. Ensure they match the architecture (`arm64` or `amd64`) defined in the Karpenter provisioners.

---

Let me know if you have any questions or need further clarification.
