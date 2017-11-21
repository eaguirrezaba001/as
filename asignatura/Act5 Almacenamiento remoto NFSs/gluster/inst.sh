# De


# A Vagrant plugin that helps you reduce the amount of coffee you drink while waiting for boxes to be provisioned by sharing a common package cache among similar VM instances. Kinda like vagrant-apt_cache or this magical snippet but targeting multiple package managers and Linux distros.
vagrant plugin install vagrant-cachier

# 3-node GlusterFS cluster

git clone https://github.com/carmstrong/multinode-glusterfs-vagrant.git

# Prueba
vagrant ssh gluster-server-1 -c 'sudo gluster peer probe 172.21.12.12 ; sudo gluster peer probe 172.21.12.13'

# Crear volumen en el subdirectorio /brick (se puede usar una partición aparte
vagrant ssh gluster-server-1 -c 'sudo gluster volume create glustertest replica 3 transport tcp 172.21.12.11:/brick 172.21.12.12:/brick 172.21.12.13:/brick force'
vagrant ssh gluster-server-1 -c 'sudo gluster volume start glustertest'

# Montar el volumen
vagrant ssh gluster-client -c 'sudo mkdir /mnt/glusterfs && sudo mount -t glusterfs 172.21.12.11:/glustertest /mnt/glusterfs'

# Usar
vagrant ssh gluster-server-1 -c 'sudo gluster volume start glustertest'
vagrant ssh gluster-client -c 'echo hello | sudo tee /mnt/glusterfs/f.txt'

vagrant ssh gluster-server-1 -c 'sudo ls -al /brick/'

vagrant ssh gluster-server-1
sudo gluster peer status
sudo gluster volume info

vagrant destroy -f

# Más info: https://gluster.readthedocs.io/en/latest/Quick-Start-Guide/Quickstart/


#################################################
### Docker

# http://www.computerweekly.com/feature/Docker-storage-how-to-get-persistent-storage-in-Docker

# https://serverfault.com/questions/677370/is-it-a-good-idea-to-store-docker-volumes-in-glusterfs


#################################################
### Kubernetes
# https://github.com/gluster/gluster-kubernetes

# https://medium.com/@jaime_ecom/glusterfs-cluster-with-kubernetes-c09725d69900
