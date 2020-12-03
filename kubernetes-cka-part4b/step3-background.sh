#!/bin/bash

#kubectl create ns gamma
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/gamma-namespace.yaml

kubectl delete all  --all -n alpha
kubectl delete all --all -n beta

kubectl apply -f  https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/exceeding-pod.yaml -n  gamma


kubectl apply -f  https://github.com/djkormo/katacoda-scenarios/blob/master/kubernetes-cka-part4b/assets/exceeding-resource.yaml  -n  gamma














