#!/bin/bash

# Deploy Træfik using a Deployment or DaemonSet
#./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml

# Submitting An Ingress to the cluster.
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/ui.yaml
# Con el plugin Vagrant-Landrush no es necesario editar el fichero hosts
# echo "$(minikube ip) traefik-ui.minikube" | sudo tee -a /etc/hosts

# Name based routing
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
# Con el plugin Vagrant-Landrush no es necesario editar el fichero hosts
# echo "$(minikube ip) stilton.minikube cheddar.minikube wensleydale.minikube" | sudo tee -a /etc/hosts

# Path based routing
./kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheeses-ingress.yaml
# Con el plugin Vagrant-Landrush no es necesario editar el fichero hosts
# echo "$(minikube ip) cheeses.minikube" | sudo tee -a /etc/hosts



