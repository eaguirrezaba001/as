#!/bin/bash

echo "Provisioning virtual machine..."


apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common >/dev/null

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -  >/dev/null

add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"  >/dev/null

apt-get update  >/dev/null

apt-get -y install docker-engine docker-compose >/dev/null

docker run hello-world

groupadd docker

adduser ubuntu docker

cd /vagrant/

# docker-compose up

# docker images
# docker ps
# docker exec -it vagrant_gitlab_1 bash
# http://localhost:8931/gitlab/users/sign_in
