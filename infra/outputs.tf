output "cluster_name" {
  value = google_container_cluster.gke.name
}

output "project_id" {
  value = var.project_id
}

output "zone" {
  value = var.zone
}

# Note: unlike AKS's kube_config_raw, GKE credentials aren't produced by
# Terraform. Fetch them with:
#   gcloud container clusters get-credentials <cluster_name> --zone <zone> --project <project_id>
