#!/bin/bash

# kubectl create ns beta

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/beta-namespace.yaml

kubectl delete all --all -n alpha



kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/missing-configmap.yaml -n beta 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/missing-secret.yaml -n beta










