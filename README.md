## Introduction to CI/CD 

![image](https://user-images.githubusercontent.com/107435692/232263168-5e313482-4b53-4824-88f3-fa2a71cfca66.png)

##  **STEPS FOR CI/CD PIPELINE USING JENKINS** 

## 1) jenkins set up

Run jekins setup script

## 1.1) get password for login

cat /var/lib/jenkins/secrets/initialAdminPassword

## 1.2) Create a user

## 2) RUN FIRST JOB

Click new item > Name: Hello world > select freestyle project > Build Steps > Select Execute on shell > echo "Hello World!" && uptime > Save.

## 2.1) RUN YOUR FIRST JOB

Click on Build now > Check build history > See output.

## 2.2) SSH into the Machine to check the jobs directory all jobs are listed in the dirctory.

cat /var/lib/jenkins/workspace/

## 3) Integrate Git with Jenkins

![image](https://user-images.githubusercontent.com/107435692/232690489-50066483-f6ef-411d-9122-0e0b29e814b3.png)

## 3.1) Rename hostname to jenkins-server

echo "jenkins-server" > /etc/hostname

## 3.2) Install git

yum install git -y & git -v

## 3.3) Install github plugin on jenkins GUI

Click Dashboard > manage jenkins > manage pulgins > Avaliable > Search for github > check and click on install without restart.

## 3.4) configure git

Click Dashboard > manage jenkins > click tools > go for git > name git > Path to Git executable: /usr/bin/git (Exceute cmd **whereis git** to get path)> save

## 4) Run Jenkins Job to Pull Code from GitHub

Click Dashboard > new item > Name: PUllcodefromgitRepo > source code management > select git > Enter git url name > credential none > click save.

## 4.1) RUN THE JOB & check the pulled repositoy.

Click on build now > check the build history successfull.

cd /var/lib/jenkins/workspace/PullcodefromGitRepo

## 5) Integrate Maven with Jenkins

![image](https://user-images.githubusercontent.com/107435692/232700535-6415afa6-399b-423f-99ca-6c4ccf42f6ad.png)

## 5.1) INSTALL MAVEN

Search maven install & maven download > copy link from the maven download **Binary tar.gz archive**.
# Go to terminal

cd /opt

# download the maven

wget https://dlcdn.apache.org/maven/maven-3/3.9.1/binaries/apache-maven-3.9.1-bin.tar.gz

# unzip downloaded file

tar xzvf apache-maven-3.9.1-bin.tar.gz

# Rename dir to maven
mv apache-maven-3.9.1 maven

# check the version of maven

/opt/maven/bin/mvn -v

# JAVA HOME PATH TO SET IT AS ENVIRONMENT VARIABLE
M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.18.0.10-3.el9.x86_64

# TO find java home path
find / -name java-11*  
OUTPUT= /usr/lib/jvm/java-11-openjdk-11.0.18.0.10-3.el9.x86_64

## Export the variable to .bash_profile (check before executing file there should not be any path entry)

echo -e "M2_HOME=/opt/maven\nM2=/opt/maven/bin\nJAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.18.0.10-3.el9.x86_64\nPATH=b\$PATH:b\$HOME:bin:b\$JAVA_HOME:b\$M2_HOME:b\$M2\nexport PATH" >> .bash_profile && source .bash_profile

## validate path 
echo $PATH

# check maven version
mvn -v








 
