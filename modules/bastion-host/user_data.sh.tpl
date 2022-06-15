#!bin/bash

# Install Web Server

yum -y update
yum -y install httpd
PrivateIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<html><body bgcolor=black><center><h2><p><font color=red>Bastion Host by ${env} with: $PrivateIP Build by Terraform! DB-address: ${db_address}. DB-port:${db_port}</h2></center></body></html>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on

DB_ADDRESS="${db_address}"
DB_PORT="${db_port}"
BUCKET="${name_bucket}"
MOUNT="/home/ec2-user/s3disk"
REGION="eu-central-1"

# Attach developer bucket

amazon-linux-extras install epel -y
yum install s3fs-fuse -y

mkdir $MOUNT
s3fs -o allow_other -o iam_role=auto -o endpoint=$REGION -o url="https://s3-$REGION.amazonaws.com" $BUCKET $MOUNT

echo "s3fs#$BUCKET $MOUNT fuse allow_other,nonempty,use_path_request_style,iam_role=auto,url=https://s3-$REGION.amazonaws.com,endpoint=$REGION 0 0" >> /etc/fstab
