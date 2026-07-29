#!/usr/bin/env bash
set -euo pipefail

echo "==> Destroying all infra via Terraform (safer than manual GCP group delete)"
cd infra
terraform destroy -auto-approve

<<<<<<< HEAD
echo "==> Done. No GKE resources should remain — verify in GCP Console."
=======
echo "==> Done. No GKE resources should remain — verify in GCP Portal."
>>>>>>> 96ed2cb8851c07fff87a255a4b114f4318ea280a
