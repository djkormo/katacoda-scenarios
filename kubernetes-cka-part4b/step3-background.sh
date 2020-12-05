#!/bin/bash

#kubectl create ns gamma
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/gamma-namespace.yaml >>/var/log/step3-background.log 
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/gamma-resource-quota.yaml >>/var/log/step3-background.log 


kubectl delete all  --all -n alpha >>/var/log/step3-background.log 
kubectl delete all --all -n beta >>/var/log/step3-background.log 

kubectl apply -f  https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/exceeding-pod.yaml -n  gamma >>/var/log/step3-background.log 


kubectl apply -f  https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/exceeding-resource.yaml  -n  gamma >>/var/log/step3-background.log 


kubectl scale deploy nginx-deployment -n gamma --replicas=3















