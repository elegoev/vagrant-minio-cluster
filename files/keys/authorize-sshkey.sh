#!/bin/bash

# create or install key for gitlab access
SSHPRIVKEYFILENAME=id_rsa
SSHPUBKEYFILENAME=id_rsa.pub
SSHKEYPATH=/vagrant/files/keys/conextrade-dev
LOCALSSHPATH=/home/vagrant/.ssh

# add for vagrant
sudo cat $SSHKEYPATH/$SSHPUBKEYFILENAME >> $LOCALSSHPATH/authorized_keys
