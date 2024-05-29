#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
#docker pull jenkins/jenkins
#docker run -p 8080:8080 -p 50000:50000 -v home:/var/jenkins_home jenkins/jenkins