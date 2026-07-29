#!/usr/bin/env bash
set -euo pipefail

<<<<<<< HEAD
echo "==> Logging into GCP (if not already)"
az account show > /dev/null 2>&1 || az login
=======
echo "==> Checking gcloud auth (if not already)"
gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q . || gcloud auth login
>>>>>>> 96ed2cb8851c07fff87a255a4b114f4318ea280a

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
