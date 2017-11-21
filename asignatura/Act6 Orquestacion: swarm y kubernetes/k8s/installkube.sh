mkdir k8s
cd k8s

# KUBECTL

# https://kubernetes.io/docs/tasks/tools/install-kubectl/
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl

# Paquetes de Ubuntu

# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
# apt-get update
# Install docker if you don't have it already.
# apt-get install -y docker-engine
# apt-get install -y kubelet kubeadm kubernetes-cni

# https://github.com/coreos/coreos-kubernetes.git

# https://github.com/kubernetes/minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
export PATH=$(pwd):$PATH
source <(kubectl completion bash)

# https://www.linux.com/learn/getting-started-kubernetes-easy-minikube
minikube start
minikube status
kubectl get nodes
kubectl get pods
kubectl get services
minikube dashboard

#Ejemplo guestbook
kubectl create -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml
kubectl proxy
# Abrir http://localhost:8001/api/v1/proxy/namespaces/default/services/frontend

#Ejemplo nginx
kubectl run hello-nginx --image=nginx --replicas=2 --port=80
minikube service --url=true hello-nginx
minikube service hello-nginx
kubectl logs hello-nginx-2471083592-jax4u
kubectl delete deployment hello-nginx

#Ejemplo couchbase http://blog.kubernetes.io/2016/08/create-couchbase-cluster-using-kubernetes.html

kubectl run couchbase --image=arungupta/couchbase
    # Maestro
kubectl create -f https://github.com/arun-gupta/couchbase-kubernetes/blob/master/cluster/cluster-master.yml
kubectl get svc
minikube service couchbase-master-service #  usuario “Administrator” y la password “password”
    # Esclavo / worker
kubectl create -f https://github.com/arun-gupta/couchbase-kubernetes/blob/master/cluster/cluster-worker.yml
kubectl get rc
kubectl scale rc couchbase-worker-rc --replicas=3



minikube ssh
# minikube stop
# minikube delete

# Multi nodo
# https://github.com/coreos/kubernetes
# git clone https://github.com/kubernetes/kubernetes.git
# git clone https://github.com/coreos/coreos-kubernetes.git
# cd coreos-kubernetes/multi-node/vagrant
# vagrant up



# Traefik
# https://docs.traefik.io/user-guide/kubernetes/

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik.yaml
kubectl --namespace=kube-system get pods
# http://traefik-ui.local:8081
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
