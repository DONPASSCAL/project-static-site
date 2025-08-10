#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Install Nginx
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx

# Pull and run Docker container
docker pull donpasscal/static-site:latest
docker run -d -p 80:80 donpasscalaz/static-site:latest
