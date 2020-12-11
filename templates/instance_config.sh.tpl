#!/usr/bin/env bash

#------------------
# Change hostname (set_hostname = true/false)
#------------------

set_hostname=${set_hostname}

#------------------
# Grab Public and Private IP's
#------------------

private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
public_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

#------------------
# Set hostname
#------------------

az=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
coast=`echo $${az:3:1} | tr '[:upper:]' '[:lower:]'`

az_rev=`echo $${az} | rev`
zone=$${az_rev:0:1}

inst="`curl -s http://169.254.169.254/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"

node_name="$${coast}-$${zone}-${environment}-$${inst}"

if [ "$set_hostname" == "true" ] ; then
    hostname "$node_name"
fi

sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

echo "### Running Update ###"
sudo yum update -y
sudo yum install epel-release -y

sudo mkdir /deploy
sudo pushd /deploy

echo "### Installing Python 3 ###"
sudo yum install wget gcc unzip openssl-devel bzip2-devel libffi-devel zlib-devel -y
sudo wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
sudo tar xzf Python-3.7.9.tgz
pushd Python-3.7.9
sudo ./configure --enable-optimizations
sudo make install

echo "### Installing Python deps ###"

sudo rm /usr/bin/python
sudo ln -s /usr/local/bin/python3 /usr/bin/python

sudo /usr/bin/python -m pip install --upgrade pip
sudo /usr/local/bin/pip3 install boto3

echo "### Create aws directory ###"
mkdir /home/centos/.aws
pushd /home/centos/.aws
mv /tmp/credentials .


echo "### Install packages ###"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install



#//TODO Need to get this to work... Can't hit secrets manager
#echo "### Grabbing cs credentials ###"
#/usr/local/bin/python3 /tmp/cs_config.py