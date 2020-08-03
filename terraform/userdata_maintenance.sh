#!/bin/bash

sudo apt update
sudo apt -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible

sudo apt -y install git
sudo apt -y install ansible

cd /home/ubuntu
git clone https://github.com/syuren42/win-server.git
chown -R ubuntu:ubuntu win-server