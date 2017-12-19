
# install minikube & kubectl 
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl
export PATH=$(pwd):$PATH
source <(kubectl completion bash)
source <(minikube completion bash)


export KUBECONFIG=$HOME/.kube/config
sudo -E ./minikube start --vm-driver=none
sudo chown -R $USER:$USER .minikube/
sudo chown -R $USER:$USER .kube/

## COMANDOS:
# minikube status
# kubectl get nodes
# kubectl get pods
# kubectl get pods --all-namespaces
# kubectl get services
# kubectl cluster-info
# minikube dashboard
# minikube dashboard --url


