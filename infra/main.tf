terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# GKE requires the default node pool to be removed and replaced with a
# custom one, so we can size/label it ourselves (mirrors the old AKS
# default_node_pool block).
resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"

  # Deletion protection off so `terraform destroy` (cluster-down.sh) can
  # actually tear the cluster down without a manual override.
  deletion_protection = false
}

resource "google_container_node_pool" "primary" {
  name     = "default"
  cluster  = google_container_cluster.gke.name
  location = var.zone

  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 30

    labels = {
      project = "k8s-lite-deploy"
      purpose = "capstone-demo"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
