#!/bin/bash

# create or install key for gitlab access
SSHPRIVKEYFILENAME=id_rsa
SSHPUBKEYFILENAME=id_rsa.pub
SSHKEYPATH=/vagrant/files/keys/conextrade-dev
LOCALSSHPATH=/home/vagrant/.ssh
ROOTSSHPATH=/root/.ssh

# delete keys if exists
if [ -f "/home/vagrant/.ssh/id_rsa" ]
then
  sudo rm $LOCALSSHPATH/id_rsa
fi

# delete keys if exists
if [ -f "/home/vagrant/.ssh/id_rsa.pub" ]
then
  sudo rm $LOCALSSHPATH/id_rsa.pub
fi

if [ -f "$SSHKEYPATH/$SSHPRIVKEYFILENAME" ] && [ -f "$SSHKEYPATH/$SSHPUBKEYFILENAME" ]
then
  echo "ssh key $SSHKEYPATH/$SSHPRIVKEYFILENAME found"
  sudo cp $SSHKEYPATH/$SSHPRIVKEYFILENAME $LOCALSSHPATH/$SSHPRIVKEYFILENAME
  sudo cp $SSHKEYPATH/$SSHPUBKEYFILENAME  $LOCALSSHPATH/$SSHPUBKEYFILENAME
else
  echo "ssh key $LOCALSSHPATH/$SSHPRIVKEYFILENAME created"
  sudo ssh-keygen -t rsa -C "developer@conextrade.com" -b 4096 -N "" -f $LOCALSSHPATH/$SSHPRIVKEYFILENAME

  if [ ! -d "$SSHKEYPATH" ]
  then
    mkdir -p $SSHKEYPATH
  fi

  sudo cp $LOCALSSHPATH/$SSHPRIVKEYFILENAME $SSHKEYPATH/$SSHPRIVKEYFILENAME
  sudo cp $LOCALSSHPATH/$SSHPUBKEYFILENAME $SSHKEYPATH/$SSHPUBKEYFILENAME
  echo "ssh key $SSHKEYPATH/$SSHPRIVKEYFILENAME saved"

fi
sudo chown vagrant $LOCALSSHPATH/$SSHPRIVKEYFILENAME
sudo chgrp vagrant $LOCALSSHPATH/$SSHPRIVKEYFILENAME
sudo chmod 600 $LOCALSSHPATH/$SSHPRIVKEYFILENAME
sudo chown vagrant $LOCALSSHPATH/$SSHPUBKEYFILENAME
sudo chgrp vagrant $LOCALSSHPATH/$SSHPUBKEYFILENAME
sudo chmod 644 $LOCALSSHPATH/$SSHPUBKEYFILENAME

# add known host
/vagrant/files/bashshell/add-known-host.sh vcs.corp.conextrade.com

# install same keys for root
if [ ! -d "$ROOTSSHPATH" ]
then
  sudo mkdir $ROOTSSHPATH
fi
sudo cp /home/vagrant/.ssh/* $ROOTSSHPATH
sudo chown root $ROOTSSHPATH/$SSHPRIVKEYFILENAME
sudo chgrp root $ROOTSSHPATH/$SSHPRIVKEYFILENAME
sudo chmod 600 $ROOTSSHPATH/$SSHPRIVKEYFILENAME
sudo chown root $ROOTSSHPATH/$SSHPUBKEYFILENAME
sudo chgrp root $ROOTSSHPATH/$SSHPUBKEYFILENAME
sudo chmod 644 $ROOTSSHPATH/$SSHPUBKEYFILENAME

# add key to authorized_keys
cat $LOCALSSHPATH/$SSHPUBKEYFILENAME >> $LOCALSSHPATH/authorized_keys
