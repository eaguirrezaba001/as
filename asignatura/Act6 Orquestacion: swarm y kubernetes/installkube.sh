mkdir k8s
cd k8s

# http://omerio.com/2015/12/18/learn-the-kubernetes-key-concepts-in-10-minutes/

# KUBECTL
# https://www.gitbook.com/book/ramitsurana/awesome-kubernetes/details
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

# Creamos un pod (3 réplicas de nginx)
pod.yaml

apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
        env: prod
        role: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 250m
          limits:
            cpu: 500m

kubectl create -f pod.yaml

kubectl describe pod nginx-deployment

# El servicio es una capa sobre el pod para hacerlo visible
service.yaml # https://hackernoon.com/kubernetes-101-2-3fdd96c7fe86

apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx
    role: web
    env: prod
  name: nginxservice
spec:
  ports:
    - port: 80
  selector:
    app: nginx
    role: web
    env: prod
  type: NodePort

kubectl describe service nginxservice

http://192.168.99.100:30070/

# actualización de la imagen de Docker
kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
kubectl describe deployments

# shell dentro de un contenedor de los del pod
kubectl get pods
kubectl exec nginx-deployment-2743933351-268sd -it sh


#replication controller
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
        env: prod
        role: web
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80


kubectl create -f rc.yaml
kubectl describe replicationcontrollers/nginx
kubectl delete pod nginx-k7j9d

# controlamos qué pods hay
kubectl get pods
kubectl scale --replicas=15 replicationcontroller/nginx
kubectl get pods
kubectl scale --replicas=5 replicationcontroller/nginx
kubectl get pods

# Más alto nivel: deployments
# https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

apiVersion: apps/v1beta2 # for versions before 1.8.0 use apps/v1beta1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80

kubectl create -f https://raw.githubusercontent.com/kubernetes/website/master/docs/concepts/workloads/controllers/nginx-deployment.yaml
kubectl get deployments
kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1
kubectl rollout status deployment/nginx-deployment


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
minikube stop
minikube delete

# Multi nodo
# https://github.com/coreos/kubernetes
# git clone https://github.com/kubernetes/kubernetes.git
# git clone https://github.com/coreos/coreos-kubernetes.git
# cd coreos-kubernetes/multi-node/vagrant
# vagrant up
https://www.techrepublic.com/article/how-to-install-the-necessary-components-for-a-kubernetes-cluster-on-ubuntu-linux/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# https://kubernetes.io/docs/concepts/storage/volumes/

# Traefik
# https://docs.traefik.io/user-guide/kubernetes/


export PATH=$HOME:$PATH
source <(kubectl completion bash)
minikube start
minikube status
kubectl get nodes
kubectl get pods
kubectl get services
minikube dashboard



kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml
# http://192.168.99.100:8080/dashboard/#/
# https://github.com/containous/traefik/tree/master/examples/k8s/traefik-deployment.yaml

kubectl --namespace=kube-system get pods
kubectl get services --namespace=kube-system
minikube ip
curl $(minikube ip)
# We expect to see a 404 response here as we haven't yet given Træfik any configuration.
# http://192.168.99.100:8080


# kubectl apply -f ejemplotraefik-quesos.yaml
# kubectl apply -f ejemplotraefik-quesos-ingress.yaml
# kubectl apply -f ejemplotraefik-path.yaml
# https://docs.traefik.io/user-guide/kubernetes/

# http://traefik-ui.local:8081
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-deployments.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-services.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/cheese-ingress.yaml
