#!bin/bash

# Install Java for Jenkins

sudo yum -y update
sudo amazon-linux-extras install -y java-openjdk11
sudo yum -y install java-1.8.0-openjdk

# Install Jenkins

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum -y upgrade
sudo yum -y update
# Add required dependencies for the jenkins package
sudo yum -y install jenkins
sudo service jenkins start
