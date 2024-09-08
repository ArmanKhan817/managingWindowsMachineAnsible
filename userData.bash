#!/bin/bash
sudo yum -y update
sudo yum install -y ruby
sudo yum install -y aws-cli
sudo yum install -y ansible
cd/home/ubuntu
chmod +x./install
./install auto
ssh-keygen -t rsa -b 4096	
chmod 600 ~/.ssh/id_rsa
