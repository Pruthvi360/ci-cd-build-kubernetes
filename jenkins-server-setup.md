Jenkins Redhat Packages
To use this repository, run the following command:


  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  
If you've previously imported the key from Jenkins, the rpm --import will fail because you already have a key. Please ignore that and move on.


  yum install fontconfig java-11-openjdk
  yum install jenkins
  
The rpm packages were signed using this key:

pub   rsa4096 2020-03-30 [SC] [expires: 2023-03-30]
      62A9756BFD780C377CF24BA8FCEF32E745F2C3D5
uid                      Jenkins Project 
sub   rsa4096 2020-03-30 [E] [expires: 2023-03-30]

