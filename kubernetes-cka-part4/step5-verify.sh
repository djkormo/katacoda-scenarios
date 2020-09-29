#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/epsilon.log

kubectl get svc nginx -n epsilon -o yaml |grep "nodePort: 30001" \
&& kubectl get svc nginx -n epsilon -o yaml |grep "targetPort: 80" \
&& kubectl get svc nginx -n epsilon -o yaml |grep selector: -A2 |grep "app: nginx" \
&& cat /tmp/epsilon.log | grep "<h1>Welcome to nginx" \
&& kubectl get pod -n kube-system |grep kube-scheduler |grep Running \
&& echo "done" 

