#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
#launch.sh
echo "done" >> /opt/.clusterstarted


echo "start" >> /opt/.krewinstall
#install-krew.sh >> /opt/.krewinstall
#export PATH="${PATH}:${HOME}/.krew/bin" >> /opt/.krewinstall
echo "done" >> /opt/.krewinstall


#kubectl create ns alpha
kubectl create namespace alpha --dry-run=client -o yaml | kubectl apply -f -


# based on 
# https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

## Installing metrics server 

#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml

kubectl delete deploy --all -n alpha
kubectl delete svc --all -n alpha

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-master-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-master-service.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-slave-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-slave-service.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/frontend-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/frontend-service.yaml -n alpha 


## Installing metrics server 
#git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
#kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log


