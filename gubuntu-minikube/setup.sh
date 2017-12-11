#!/bin/bash

# Gnome
sudo apt-get install -y gdm gnome-shell whois
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Utilities
sudo apt-get install -y nautilus
sudo apt-get install -y gnome-terminal
sudo apt-get install -y docker.io

# user
useradd -d /home/$1 -m $1 -p `mkpasswd $1`
usermod -aG sudo $1

# keyboard locale
#localectl set-keymap es

reboot

