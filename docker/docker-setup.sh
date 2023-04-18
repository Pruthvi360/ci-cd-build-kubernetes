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

# Check docker Tomcat container running

docker ps
DOCKER_ID=$(docker ps | sed -n '/1/p' | awk '{print $1}')

# GO INSIDE THE CONTAINER

docker exec -it $DOCKER_ID /bin/bash

# COPY FROM WEBAPPS.DIST DIRECTORY TO WEBAPPS DIR TO MAKE TOMCAT CONTAINER TO WORK.

cd webapps.dist/ && cp -R * ../webapps/

# PROVIDE OUTSIDE ACCESS TO THE TOMCAT SERVER

sed -i '21,22d' /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '21,22d' /usr/local/tomcat/webapps/manager/META-INF/context.xml
sed -i '19,20d' /usr/local/tomcat/webapps/docs/META-INF/context.xml


## delete users

sed -i '49,56d' /usr/local/tomcat/conf/tomcat-users.xml

## Insert users

echo "
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-jmx"/>
  <role rolename="manager-status"/>
  <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
  <user username="deployer" password="deployer" roles="manager-script"/>
  <user username="tomcat" password="s3cret" roles="manager-gui"/>
  </tomcat-users>" >> /usr/local/tomcat/conf/tomcat-users.xml
