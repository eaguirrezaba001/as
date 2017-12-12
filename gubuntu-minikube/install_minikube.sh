
# install minikube & kubectl 
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl
export PATH=$(pwd):$PATH
source <(kubectl completion bash)
source <(minikube completion bash)

#export MINIKUBE_WANTUPDATENOTIFICATION=false
#export MINIKUBE_WANTREPORTERRORPROMPT=false
#export MINIKUBE_HOME=$HOME
#export CHANGE_MINIKUBE_NONE_USER=true
#mkdir $HOME/.kube || true
#touch $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config
sudo -E ./minikube start --vm-driver=none
sudo chown -R $USER:$USER .minikube/
sudo chown -R $USER:$USER .kube/

# this for loop waits until kubectl can access the api server that Minikube has created
for i in {1..150}; do # timeout for 5 minutes
   ./kubectl get po &> /dev/null
   if [ $? -ne 1 ]; then
      break
  fi
  sleep 2
done

# kubectl commands are now able to interact with Minikube cluster
# minikube status
# kubectl get nodes
# kubectl get pods
# kubectl get pods --all-namespaces
# kubectl get services
# kubectl cluster-info
# minikube dashboard
# minikube dashboard --url


