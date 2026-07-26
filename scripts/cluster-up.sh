#!/usr/bin/env bash
set -euo pipefail

echo "==> Logging into Azure (if not already)"
az account show > /dev/null 2>&1 || az login

echo "==> Initializing Terraform"
cd infra
terraform init

echo "==> Applying Terraform (creates resource group + AKS)"
terraform apply -auto-approve

echo "==> Fetching kubeconfig"
RG=$(terraform output -raw resource_group)
CLUSTER=$(terraform output -raw cluster_name)
az aks get-credentials --resource-group "$RG" --name "$CLUSTER" --overwrite-existing

echo "==> Cluster is up. kubectl is now pointed at it."
kubectl get nodes