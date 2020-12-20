#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted



## Installing metrics server 
git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log


kubectl create ns alpha >>/var/log/step1-background.log
kubectl run fix-me --image=nginx:3 -n alpha >>/var/log/step1-background.log






