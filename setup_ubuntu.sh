#!/bin/bash

# install git
sudo apt-get install git -y

# uninstall old version of docker
sudo apt-get remove docker docker-engine docker.io -y

# update packages 
sudo apt-get update -y

# install linux-extra-image-*
sudo apt-get install linux-image-extra-$(uname -r) -y
sudo apt-get install linux-image-extra-virtual -y

# update packages 
sudo apt-get update -y

# install dependencies
sudo apt-get install apt-transport-https -y
sudo apt-get install ca-certificates -y
sudo apt-get install curl -y
sudo apt-get install software-properties-common -y

# add the docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# test the key fingerprint 
sudo apt-key fingerprint 0EBFCD88

# add the repository / package 
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update packages 
sudo apt-get update -y

# and (finally) the actual install
sudo apt-get install docker-ce -y

# download the latest version of docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# change the permissions 
sudo chmod +x /usr/local/bin/docker-compose

# add current user to the docker group
sudo usermod -aG docker $USER

# test that docker works ok
docker run hello-world

# verify the docker-compose version 
docker-compose --version

# get the docker compose file 
wget https://raw.githubusercontent.com/Nameles-Org/Nameles-streaming/master/nameles-docker-compose.yml

# execute compose
sudo docker-compose -f nameles-docker-compose.yml up
