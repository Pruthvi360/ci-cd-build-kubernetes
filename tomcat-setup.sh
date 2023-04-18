#!/usr/bin/env bash

install java 11

sudo yum install java-11-openjdk -y

# install wget
yum install wget -y

# Create tomcat directory

cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz
tar -xvzf /opt/apache-tomcat-10.1.7.tar.gz

## change execution permission

chmod +x /opt/apache-tomcat-10.1.7/bin/startup.sh 
chmod +x /opt/apache-tomcat-10.1.7/bin/shutdown.sh

## create link files for tomcat startup.sh and shutdown.sh

ln -s /opt/apache-tomcat-10.1.7/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat-10.1.7/bin/shutdown.sh /usr/local/bin/tomcatdown

## 
