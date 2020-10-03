#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

# based on 
# https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

kubectl delete pod --all -n alpha
kubectl delete secret --all -n alpha
kubectl delete cm --all -n alpha
kubectl delete deploy --all -n alpha
kubectl delete svc --all -n alpha

sleep 10