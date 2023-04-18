#!/usr/bin/env bash

# Install the required packages.
sudo yum install -y yum-utils \
device-mapper-persistent-data \
lvm2

# Use the following command to set up the stable repository.

sudo yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo

# Install the latest version of Docker CE.

sudo yum install docker-ce -y

# Start Docker.

sudo systemctl start docker

# Run Tomcat docker continer

docker run -d --name test-tomcat-server -p 8090:8080 tomcat:latest
