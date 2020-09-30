#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/zeta.log

kubectl get svc nginx -n zeta -o yaml |grep "nodePort: 30001" \
&& kubectl get svc nginx -n zeta -o yaml |grep "targetPort: 80" \
&& kubectl get svc nginx -n zeta -o yaml |grep selector: -A2 |grep "app: nginx" \
&& cat /tmp/zeta.log | grep "<h1>Welcome to nginx" \
&& kubectl get pod -n kube-system |grep kube-scheduler |grep Running \
&& kubectl get deploy nginx-deployment -n lambda -o yaml | grep "replicas: 4" \
&& echo "done" 

