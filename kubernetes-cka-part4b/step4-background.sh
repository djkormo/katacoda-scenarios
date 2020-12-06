#!/bin/bash



kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4b/assets/delta-namespace.yaml >>/var/log/step4-background.log

kubectl delete all --all-n alpha  >>/var/log/step4-background.log 
kubectl delete all --all-n beta  >>/var/log/step4-background.log 
kubectl delete all --all -n gamma  >>/var/log/step4-background.log 









