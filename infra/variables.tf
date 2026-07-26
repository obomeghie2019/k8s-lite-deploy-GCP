variable "project_id" {
  description = "GCP project ID to deploy into"
  type        = string
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "cluster_name" {
  default = "gke-k8s-lite"
}

variable "node_machine_type" {
  # e2-small is the free-tier-safe default. If a project's quota rejects
  # e2-micro-class nodes, e2-small is still small and cheap.
  default = "e2-small"
}

variable "node_count" {
  default = 1
}
