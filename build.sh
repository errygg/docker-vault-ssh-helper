#!/bin/bash
if [ $# -eq 0 ]
then
  tag='latest'
else
  tag=$1
fi

docker build -t errygg/vault-ssh-helper:$tag .
