#!/bin/bash

## SOURCE: https://www.stratoscale.com/blog/kubernetes/installing-kubernetes-bare-metal/

# deben existir los ficheros 'Vagrantfile' y 'install.sh'
vagrant up

# iniciar el cluster en el nodo maestro
vagrant ssh master
sudo kubeadm init --apiserver-advertise-address=192.168.77.10 --pod-network-cidr=10.244.0.0/16
# se confirma por consola que ha arrancado, copiar la ultima linea 'kubeadm join --token...' y ejecutar:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# configurar la red para los pod, con el plugin de Flannel
# ver otros: https://www.stratoscale.com/blog/kubernetes/networking-in-kubernetes/
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml
# se obtiene 'FileNotFound', alternativa:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
# otros...
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-legacy.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-aliyun.yml

# mostrar todos los pods
kubectl get pods --all-namespaces
# mostrar todos los nodos
kubectl get nodes

# iniciar el nodo worker
vagrant ssh worker
# registrar el nodo como parte del cluster
kubeadm join --token c93f3a.0986ac0f020d63e6 192.168.77.10:6443 --discovery-token-ca-cert-hash sha256:fe5d9ba2502508782d35ccca3e6876cfddb4f65672284a18f9ea830bfb88fdb0

