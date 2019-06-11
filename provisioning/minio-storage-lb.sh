#!/usr/bin/env bash

# Ubuntu update
sudo apt update

# enable ssh connectivity
sudo /vagrant/files/bashshell/enable-insecure-key.sh

# install haproxy
apt-get install -y haproxy hatop
cp /vagrant/files/apps/haproxy/storage-lb.cfg /etc/haproxy/haproxy.cfg
echo "ENABLED=1" > /etc/default/haproxy
systemctl restart haproxy
