#!/bin/bash

sudo apt-get install -y whois
# Gnome
sudo apt-get install -y gdm gnome-shell
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Utilities
sudo apt-get install -y nautilus
sudo apt-get install -y gnome-terminal
sudo apt-get install -y docker.io
sudo apt-get install -y firefox

# user
sudo useradd -d /home/$1 -m $1 -p `mkpasswd $1`
sudo usermod -aG sudo $1

# WORKAROUND for private network error
# SOURCE: https://bugs.launchpad.net/ubuntu/+source/ubuntu-fan/+bug/1729608
sudo mv /etc/network/fan /etc/network/fan.backup

# Workaround for docker networking issues + landrush                                                         
#SOURCE: https://github.com/vagrant-landrush/landrush/issues/293
echo "$(host -t A index.docker.io | grep has.address | head -1 | awk '{print $NF}') index.docker.io" >> /etc/hosts
echo "$(host -t A registry-1.docker.io | grep has.address | head -1 | awk '{print $NF}') registry-1.docker.io" >> /etc/hosts

#loadkeys es
#setxkbmap es


