#!/bin/bash

# kubectl create ns beta

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/beta-namespace.yaml >>/var/log/step2-background.log 

kubectl delete all --all -n alpha >>/var/log/step2-background.log



kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/missing-configmap.yaml -n beta >>/var/log/step2-background.log 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/missing-secret.yaml -n beta >>/var/log/step2-background.log 










