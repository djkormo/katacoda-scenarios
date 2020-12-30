#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


kubectl delete pod --all -n alpha
kubectl delete secret --all -n alpha
kubectl delete cm --all -n alpha
kubectl delete deploy --all -n alpha
kubectl delete svc --all -n alpha


kubectl label node controlplane whereareyou=master --overwrite
kubectl label node node01 whereareyou=worker --overwrite

kubectl create ns beta 

sleep 10