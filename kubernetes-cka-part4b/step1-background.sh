#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

kubectl create ns alpha

# based on 
# https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

## Installing metrics server 

#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml


#sleep 1
#cd /manifests
#ls
#kubectl run fix-me --image=nginx:3
#kubectl apply -f nginx-deployment.yml
#clear




