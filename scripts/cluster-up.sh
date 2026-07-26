#!/usr/bin/env bash
set -euo pipefail

echo "==> Checking gcloud auth (if not already)"
gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q . || gcloud auth login

echo "==> Initializing Terraform"
cd infra
terraform init

echo "==> Applying Terraform (creates GKE cluster + node pool)"
terraform apply -auto-approve

echo "==> Fetching kubeconfig"
PROJECT=$(terraform output -raw project_id)
ZONE=$(terraform output -raw zone)
CLUSTER=$(terraform output -raw cluster_name)
gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE" --project "$PROJECT"

echo "==> Cluster is up. kubectl is now pointed at it."
kubectl get nodes
