#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

## Installing metrics server 


git clone https://github.com/vocon-it/metrics-server

kubectl apply -f ./metrics-server/deploy/1.8+/

kubectl create ns alpha

kubectl run fix-me --image=nginx:3 -n alpha




