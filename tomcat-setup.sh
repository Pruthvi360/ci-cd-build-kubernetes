#!/usr/bin/env bash

#install java 11

sudo yum install java-11-openjdk -y

# install wget
yum install wget -y

# install nano editor

yum install nano -y

# Create tomcat directory

cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.8/bin/apache-tomcat-10.1.8.tar.gz
tar -xvzf /opt/apache-tomcat-10.1.8.tar.gz

## change execution permission

chmod +x /opt/apache-tomcat-10.1.8/bin/startup.sh 
chmod +x /opt/apache-tomcat-10.1.8/bin/shutdown.sh

## Run startup.sh

/opt/apache-tomcat-10.1.8/bin/startup.sh

## Editing context.xml to make sure the it is accessable from outside than local host 127.0.0.0

sed -i '21,22d' /opt/apache-tomcat-10.1.8/webapps/host-manager/META-INF/context.xml
sed -i '21,22d' /opt/apache-tomcat-10.1.8/webapps/manager/META-INF/context.xml
sed -i '19,20d' /opt/apache-tomcat-10.1.8/webapps/docs/META-INF/context.xml

## create link files for tomcat startup.sh and shutdown.sh

#cd ~

#echo -e "PATH=/usr/local/sbin:/usr/local/bin:b\$PATH:b\$HOME:bin\nexport PATH" >> .bash_profile && source .bash_profile

ln -s /opt/apache-tomcat-10.1.8/bin/startup.sh /usr/bin/tomcatup
ln -s /opt/apache-tomcat-10.1.8/bin/shutdown.sh /usr/bin/tomcatdown

## delete users

sed -i '49,56d' /opt/apache-tomcat-10.1.8/conf/tomcat-users.xml

## Insert users

echo "
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-jmx"/>
  <role rolename="manager-status"/>
  <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
  <user username="deployer" password="deployer" roles="manager-script"/>
  <user username="tomcat" password="s3cret" roles="manager-gui"/>
</tomcat-users>" >> /opt/apache-tomcat-10.1.8/conf/tomcat-users.xml


## Starting tomcatserver

tomcatdown
tomcatup

