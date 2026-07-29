#!/usr/bin/env bash
set -euo pipefail

echo "==> Destroying all infra via Terraform (safer than manual az group delete)"
cd infra
terraform destroy -auto-approve

echo "==> Done. No GKE resources should remain — verify in GCP Console."