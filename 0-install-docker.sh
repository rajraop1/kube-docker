#!/bin/bash

#From this url:
#https://docs.docker.com/engine/install/ubuntu/


sudo apt-get update

sudo apt-get install \
	--assume-yes \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install --assume-yes docker-ce docker-ce-cli containerd.io docker-compose

sudo docker run hello-world

sudo groupadd docker

sudo usermod -aG docker $USER

echo Now executing new group to update group membership
echo Exit now

newgrp docker 

docker run hello-world

sudo systemctl enable docker.service

sudo systemctl enable containerd.service

echo running as regular user

docker images

echo Check if above command showed list of images i.e. hello-world
