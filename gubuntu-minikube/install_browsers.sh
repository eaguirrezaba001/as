#!/bin/bash

echo "Installing Google Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get install -y google-chrome-stable
echo "Done !!!"

echo "Installing Mozilla Firefox..."
sudo apt-get install -y firefox
echo "Done !!!"

