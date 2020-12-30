#!/usr/bin/env bash

#kubectl get pod nginx-pod-request-limit -n alpha -o yaml | grep "image: nginx:1.18.0" \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml | grep "image: nginx:1.18.0" \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml | grep "containerPort: 80" \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml |grep "limits:" -A2 | grep "cpu: 200m"  \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml |grep "limits:" -A2 |grep "memory: 700Mi" \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml |grep "requests:" -A2 |grep "cpu: 100m" \
#  && kubectl get deploy nginx-deployment-request-limit -n alpha -o yaml |grep "requests:" -A2 |grep "memory: 500Mi" \
#  && kubectl get service nginx-service-request-limit -n alpha -o yaml |grep "port: 80" \
#  && echo "done" 
  
