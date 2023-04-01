yum install wget -y

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  
yum install fontconfig java-11-openjdk -y

yum install jenkins  -y

systemctl start jenkins
