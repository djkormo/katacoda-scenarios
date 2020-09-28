#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

kubectl create ns delta

# based on 
# https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

kubectl delete deploy --all -n alpha
kubectl delete svc --all -n alpha

kubectl delete deploy --all -n beta
kubectl delete svc --all -n beta

kubectl delete deploy --all -n gamma
kubectl delete svc --all -n gamma

kubectl delete deploy --all -n delta
kubectl delete svc --all -n delta

sleep 10

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/redis-master-deployment.yaml -n delta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/redis-master-service.yaml -n delta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/redis-slave-deployment.yaml -n delta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/redis-slave-service.yaml -n delta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/frontend-deployment.yaml -n delta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step4/frontend-service.yaml -n delta 

sleep 10