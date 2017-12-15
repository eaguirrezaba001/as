#!/bin/bash

sudo apt-get install -y whois
# Gnome
sudo apt-get install -y gdm gnome-shell
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Utilities
sudo apt-get install -y nautilus
sudo apt-get install -y gnome-terminal
sudo apt-get install -y docker.io

# user
useradd -d /home/$1 -m $1 -p `mkpasswd $1`
usermod -aG sudo $1

# WORKAROUND for private network error
# https://bugs.launchpad.net/ubuntu/+source/ubuntu-fan/+bug/1729608
sudo mv /etc/network/fan /etc/network/fan.backup

# Workaround for docker networking issues + landrush                                                         
echo "$(host -t A index.docker.io | grep has.address | head -1 | awk '{print $NF}') index.docker.io" >> /etc/hosts
echo "$(host -t A registry-1.docker.io | grep has.address | head -1 | awk '{print $NF}') registry-1.docker.io" >> /etc/hosts


#keyboard locale
#localectl set-keymap es
#setxkbmap -layout us,es
#setxkbmap es
#sudo dpkg-reconfigure console-setup
#sudo dpkg-reconfigure keyboard-configuration

#reboot

