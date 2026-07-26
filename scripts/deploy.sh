#!/usr/bin/env bash
set -euo pipefail

echo "==> Applying app manifests"
kubectl apply -k k8s/

echo "==> Adding Prometheus community Helm repo"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "==> Installing kube-prometheus-stack (Prometheus + Grafana + Alertmanager)"
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace \
  -f monitoring/values-kube-prometheus-stack.yaml

echo "==> Applying custom alert rule"
kubectl apply -f monitoring/alert-rules.yaml

echo "==> Deploy complete. Waiting for pods..."
kubectl get pods -A

echo "==> Creating Grafana admin secret"
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic grafana-admin-secret \
  --namespace monitoring \
  --from-literal=admin-user=admin \
  --from-literal=admin-password="${GRAFANA_ADMIN_PASSWORD:?Set GRAFANA_ADMIN_PASSWORD env var first}" \
  --dry-run=client -o yaml | kubectl apply -f -