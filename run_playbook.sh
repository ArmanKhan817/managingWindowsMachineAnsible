#!/bin/bash
cd /home/ec2-user/
sudo ansible-playbook -i win_server.ini downloadPutty.yml
