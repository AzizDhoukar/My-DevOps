#!/bin/bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

#sudo apt update
#sudo apt install git openjdk-17-jre -y
#sudo useradd -d /var/lib/jenkins jenkins