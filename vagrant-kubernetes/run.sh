#!/bin/bash

export KUBERNETES_PROVIDER=vagrant
export NUM_NODES=1
export VAGRANT_NO_PROXY=127.0.0.1

cd /tmp
curl -sS https://get.k8s.io | bash
cd kubernetes
./cluster/kube-up.sh

## To access the master or any node:
#vagrant ssh master
#vagrant ssh node-1
#vagrant ssh node-2

## To view the service status and/or logs on the kubernetes-master:
#vagrant ssh master
#sudo su
#systemctl status kubelet
#journalctl -ru kubelet
#systemctl status docker
#journalctl -ru docker
#tail -f /var/log/kube-apiserver.log
#tail -f /var/log/kube-controller-manager.log
#tail -f /var/log/kube-scheduler.log

## To view the services on any of the nodes:
#vagrant ssh node-1
#sudo su
#systemctl status kubelet
#journalctl -ru kubelet
#systemctl status docker
#journalctl -ru docker




