#!/bin/bash

k8s_env=$1 

if [ "$k8s_env" == "test" ]; then
    kubectx gke_sauce-container-beta_us-west1-c_headless-test
    env_settings="headless-test.yaml"
elif [  "$k8s_env" == "east1" ]; then 
    kubectx gke_sauce-container-beta_us-east1-b_us-east1
    env_settings="headless-east1.yaml"
else
    echo "Unrecognized Environment: $k8s_env"
    exit 1
fi

echo grafana: > custom-dashboards.yaml
echo "  serverDashboardFiles:" >> custom-dashboards.yaml
cat dashboards/*-dashboard.yaml | sed 's/^/    /' >> custom-dashboards.yaml

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm upgrade --install --namespace monitoring --set rbacEnable=false prometheus-operator coreos/prometheus-operator

helm upgrade --install --namespace monitoring \
    -f headless-settings.yaml \
    -f "$env_settings" \
    -f custom-dashboards.yaml \
    kube-prometheus coreos/kube-prometheus

rm custom-dashboards.yaml
