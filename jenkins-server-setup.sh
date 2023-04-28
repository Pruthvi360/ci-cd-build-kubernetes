sudo yum install wget -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
    
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key

sudo yum upgrade -y

# Add required dependencies for the jenkins package
sudo yum install java-11-openjdk -y

sudo yum install jenkins -y

systemctl start jenkins
