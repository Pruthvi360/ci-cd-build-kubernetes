FROM centos:latest
RUN yum install java -y
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz /opt/tomcat
RUN tar -xvzf apache-tomcat-10.1.7.tar.gz
RUN mv apache-tomcat-10.1.7/* /opt/tomcat
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh" , "run"]
