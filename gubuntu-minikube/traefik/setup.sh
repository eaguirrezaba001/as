#!/bin/bash

export PATH=$(pwd):$PATH
source <(kubectl completion bash)
source <(minikube completion bash)

# Deploy Træfik using a Deployment
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml

# Submitting An Ingress to the cluster.
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml
echo "$(minikube ip) traefik-ui.minikube" | sudo tee -a /etc/hosts

# Name based routing
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
echo "$(minikube ip) stilton.minikube cheddar.minikube wensleydale.minikube" | sudo tee -a /etc/hosts
