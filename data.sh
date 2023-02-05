#!/bin/bash
yum update -y
yum install -y git
yum install -y httpd
systemctl start httpd
systemctl enable httpd

