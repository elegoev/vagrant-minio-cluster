#!/bin/bash

# export MINIO_VOLUMES="/usr/local/share/minio/"
# export MINIO_OPTS="-C /etc/minio --address minio.example.com:443"
# export MINIO_ACCESS_KEY=minio-admin
# export MINIO_SECRET_KEY=minio-admin

# minio server http://192.168.1.1{1...8}/export1
sudo -u minio-user minio server http://172.16.1.6{1...4}/usr/local/share/minio -C /etc/minio 
# minio server http://172.16.1.6{1...4}/usr/local/share/minio
