#!/usr/bin/env bash

# Create tomcat directory
cd /opt
wget [http://mirrors.fibergrid.in/apache/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz](https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz)
tar -xvzf /opt/apache-tomcat-10.1.7.tar.gz

## change execution permission

chmod +x /opt/apache-tomcat-10.1.7/bin/startup.sh 
chmod +x /opt/apache-tomcat-10.1.7/bin/shutdown.sh

## create link files for tomcat startup.sh and shutdown.sh

ln -s /opt/apache-tomcat-<version>/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat-<version>/bin/shutdown.sh /usr/local/bin/tomcatdown

## 
