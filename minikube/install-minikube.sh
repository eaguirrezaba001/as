#!/bin/bash

cd $HOME

# descargar y hacer ejecutable kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
# descargar y hacer ejecutable minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
# autocompletion para comando kubectl
export PATH=$(pwd):$PATH
source <(kubectl completion bash)
# arrancar minikube
minikube start

# this for loop waits until kubectl can access the api server that Minikube has created
for i in {1..150}; do # timeout for 5 minutes
   ./kubectl get po &> /dev/null
   if [ $? -ne 1 ]; then
      break
  fi
  sleep 2
done

# kubectl commands are now able to interact with Minikube cluster
echo "Minikube arrancado!!"

# Comand for get the address to access the Kubernetes Dashboard
minikube dashboard

# stop and emove minikube VM
#minikube stop
#minikube delete



