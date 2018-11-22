#!/bin/bash

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm upgrade --install --namespace monitoring --set rbacEnable=false prometheus-operator coreos/prometheus-operator
helm upgrade --install --namespace monitoring -f headless-test.yaml kube-prometheus coreos/kube-prometheus 
