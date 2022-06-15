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

# Install Web Server

BUCKET="${name_bucket}"
MOUNT="/home/ec2-user/s3disk"
REGION="eu-central-1"

# Attach developer bucket

amazon-linux-extras install epel -y
yum install s3fs-fuse -y

mkdir $MOUNT
s3fs -o allow_other -o iam_role=auto -o endpoint=$REGION -o url="https://s3-$REGION.amazonaws.com" $BUCKET $MOUNT

echo "s3fs#$BUCKET $MOUNT fuse allow_other,nonempty,use_path_request_style,iam_role=auto,url=https://s3-$REGION.amazonaws.com,endpoint=$REGION 0 0" >> /etc/fstab

cat /var/lib/jenkins/secrets/initialAdminPassword > $MOUNT/PwdJenkins${env}.txt
