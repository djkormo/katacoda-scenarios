#!/bin/bash

kubectl create ns delta

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/delta-namespace.yaml


kubectl delete all --all-n alpha
kubectl delete all --all-n beta
kubectl delete all --all -n gamma








