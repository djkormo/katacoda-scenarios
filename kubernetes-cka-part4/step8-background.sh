#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

kubectl create ns kappa

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

kubectl delete deploy --all -n epsilon
kubectl delete svc --all -n epsilon

kubectl delete deploy --all -n zeta
kubectl delete svc --all -n zeta

kubectl delete deploy --all -n lambda
kubectl delete svc --all -n lambda

kubectl delete deploy --all -n kappa
kubectl delete svc --all -n kappa

sleep 10


kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step5/nginx-deployment.yaml -n kappa 
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step5/nginx-service.yaml -n kappa 


sed -i 's/\/etc\/kubernetes\/pki\/ca.crt/\/etc\/kubernetes\/pki\/cacert.crt/g' /var/lib/kubelet/config.yaml
kubectl delete node node01

sleep 10