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





 
