#!/usr/bin/env bash

# stop service
sudo systemctl stop minio

# delete dir
sudo rm -rf /usr/local/share/minio/.minio.sys

# overwrite service with disributed config
sudo cp /vagrant/files/apps/minio/distributed-minio.service  /etc/systemd/system/minio.service

# start service
sudo systemctl daemon-reload
sudo systemctl start minio
