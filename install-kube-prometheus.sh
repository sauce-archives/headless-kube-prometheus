#!/bin/bash

echo grafana: > dashboard-files.yaml
echo "  serverDashboardFiles:" >> dashboard-files.yaml
cat dashboards/*-dashboard.yaml | sed 's/^/    /' >> dashboard-files.yaml

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm upgrade --install --namespace monitoring --set rbacEnable=false prometheus-operator coreos/prometheus-operator
helm upgrade --install --namespace monitoring -f headless-test.yaml -f dashboard-files.yaml kube-prometheus coreos/kube-prometheus

rm dashboard-files.yaml
