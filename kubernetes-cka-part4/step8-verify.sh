#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/kappa.log

kubectl get svc nginx -n kappa -o yaml |grep "nodePort: 30001" \
&& kubectl get svc nginx -n kappa -o yaml |grep "targetPort: 80" \
&& kubectl get svc nginx -n kappa -o yaml |grep selector: -A2 |grep "app: nginx" \
&& cat /tmp/kappa.log | grep "<h1>Welcome to nginx" \
&& kubectl get deploy nginx-deployment -n kappa -o yaml | grep "replicas: 6" \
&& systemctl status kubelet | grep running \
&& kubectl get pod -n kappa | grep nginx-deployment | grep Running \
&& echo "done" 

