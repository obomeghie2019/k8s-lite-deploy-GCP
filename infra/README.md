# Infra notes

- Cluster: 1x e2-small node, GKE Standard cluster (a project's first zonal cluster is free of the cluster management fee under the GCP free tier).
- Estimated cost: ~$0.02-0.03/hr for the node while running (e2-small, on-demand). Kept under $1 total if you follow scripts/cluster-up.sh and cluster-down.sh.
- ALWAYS run scripts/cluster-down.sh after demoing — this runs `terraform destroy`, deleting the GKE cluster and its node pool.
- Set a $5 budget alert in GCP Billing before first apply (Console → Billing → Budgets & alerts → Create budget).
- Requires a GCP project with billing enabled and the Kubernetes Engine API turned on (`gcloud services enable container.googleapis.com`).

# Remember to reminding yourself to export GRAFANA_ADMIN_PASSWORD before deploying.


# THE BELOW COMMAND IN GIT BASH
# export GRAFANA_ADMIN_PASSWORD="your-real-password-here"
# ./scripts/deploy.sh
