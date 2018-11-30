# Deployment Prerequisites:

Move the sauce-traefik-default-cert from the default namespace into monitoring
```
kubectl get secret sauce-traefik-default-cert --namespace=default --export -o yaml | kubectl apply --namespace=monitoring -f -
```

# Deployment Steps
Run `./install-kube-prometheus.sh <test, east1>`

# Grafana Login

The username for grafana is 'saucelabs-admin'

The password can be obtained with:
```
kubectl get secret --namespace monitoring kube-prometheus-grafana -o jsonpath="{.data.password}" | base64 --decode ; echo
```
