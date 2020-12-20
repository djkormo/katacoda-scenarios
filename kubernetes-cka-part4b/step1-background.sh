#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


echo "start" >> /opt/.krewinstall

install-krew.sh >> /opt/.krewinstall

export PATH="${PATH}:${HOME}/.krew/bin" >> /opt/.krewinstall

echo "done" >> /opt/.krewinstall




## Installing metrics server 
git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log


kubectl create ns alpha >>/var/log/step1-background.log
kubectl run fix-me --image=nginx:3 -n alpha >>/var/log/step1-background.log






