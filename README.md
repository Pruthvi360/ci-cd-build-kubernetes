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


## 5.2) ADD MAVEN PLUGIN

Click Dashboard > manage jenkins> plugins > Available > search maven > check **maven integration** > install withour restart

## 5.3) CONFIGURE MAVEN

Click Dashboard > manage jenkins> TOOLS > 

1. jdk > Name: Java-11 > JAVA_HOME: /usr/lib/jvm/java-11-openjdk-11.0.18.0.10-3.el9.x86_64 > MAVEN ADD > Name: Maven-3.9.1 MAVEN_HOME: /opt/maven > apply & save.

## 6) Build a Java Project Using Jenkins 

# need to create Build job to build the source code pulled form the git repo.

1. Click Dashboard > new item > Name:Build_Maven_Artifact > select maven project > Source_code_management:check Git,
2. repo url:https://github.com/Pruthvi360/ci-cd-hello-world.git
3. Build > Root POM: pom.xml> Goals and options: clean install  (Check maven lifecycle)
4. Apply & save

## 6.1) Run the job & Click build history output

## 6.2) **Click Build_Maven_Artifact JOB** and navigate workspace > webapp > target > webapp.war

## 7) Set Up a Tomcat Server

![image](https://user-images.githubusercontent.com/107435692/232724693-543643d5-09cf-4192-b5f7-1ea87552ba7e.png)

## 7.1) Refer to tomcatinstall.md

follow the steps in the tomcatinstall.md to complete the installation.
Run the tomcat-setup.sh

## 8) Intergrate with Tomcat

![image](https://user-images.githubusercontent.com/107435692/232820017-c014598d-4088-458a-aae0-9a1b0a304d4b.png)

## 8.1) Install plugin Deploy-to-container

Click Dashboard > manage jenkins > plugins > available > Search: Deploy to continer > check and click install withour restart.

## 8.2) Configure Tomacat credentials

1. Click Dashboard > manage jenkins > manage credentials > system > global > select usernam & password > specify username & password >
2.  name: tomacat-deployer > description:tomcat-deployer.

## 8.3) Create new job

1. Click Dashboard > new item > Name:Deploy-to-container > Source_code_management: check git and git url > Build > Root POM: pom.xml > Goals and options: clean install
2. Post build action > select deploy to continer > specify war file path webapp/target/webapp.war or **/*.war 
3. Containers > Select Tomatcat 9 > Give credentials select from previously created > Tomcat URL: http://35.231.215.116:8080/ > click Apply and save

## 8.4) Build Now

![image](https://user-images.githubusercontent.com/107435692/232828372-05f36128-8b34-4d18-9269-9c42255ac60c.png)

## 8.5) Check the webapp directory in tomcat server

![image](https://user-images.githubusercontent.com/107435692/232829219-0910e43e-98e3-4b95-a2cd-85305074ab64.png)

## 9) Automate Deploy When any changes in the git repo for every 1 minute

Modify the existing job and Select

git clone https://github.com/Pruthvi360/ci-cd-hello-world.git

Edit index.jsp

git status                           > It should be **modified** state
git add .                            > In the current directory state should be **staging**
git commit -m "Auto Tigger to CI/CD" > In the state **commited** ready to push
git remote -v                        > used to show the remotes mapped to git remote repository
git branch                           > Check the branch
git push origin master               > push the commited changes to the repository

## 9.1) build will trigger automatically after a change within a minute

Watch the Build history in jenkins and validate the changes in the tomcat server.

## 10) Setup Docker

![image](https://user-images.githubusercontent.com/107435692/232836351-9326f625-eec4-4a89-8d05-7aa3468c7f54.png)

## 10.1) Read into Docker installation Setup

Refer the Docker-install.md file


## 11) Docker file

![image](https://user-images.githubusercontent.com/107435692/232956414-2b62078d-5b45-4723-aeba-4d121e380c7b.png)

## 11.1) Write a docker file

FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps














 
