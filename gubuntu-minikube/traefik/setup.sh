#!/bin/bash

export PATH=$(pwd):$PATH
source <(kubectl completion bash)
source <(minikube completion bash)

# Deploy Træfik using a Deployment or DaemonSet
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml'
./kubectl apply -f traefik-deployment.yaml
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml'
./kubectl apply -f traefik-ds.yaml
# Check Pods
./kubectl --namespace=kube-system get pods

# Submitting An Ingress to the cluster.
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml'0
./kubectl apply -f ui.yaml
# echo "$(minikube ip) traefik-ui.minikube" | sudo tee -a /etc/hosts

# Path based routing
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheeses-ingress.yaml'
./kubectl apply -f cheeses-ingress.yaml
# echo "$(minikube ip) cheeses.minikube" | sudo tee -a /etc/hosts

# Name based routing
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml'
./kubectl apply -f cheese-deployments.yaml
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml'
./kubectl apply -f cheese-services.yaml
echo 'SOURCE: https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml'
./kubectl apply -f cheese-ingress.yaml
# echo "$(minikube ip) stilton.minikube cheddar.minikube wensleydale.minikube" | sudo tee -a /etc/hosts
# Check Pods
./kubectl --namespace=kube-system get pods


