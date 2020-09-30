#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/lambda.log

kubectl get svc nginx -n lambda -o yaml |grep "nodePort: 30001" \
&& kubectl get svc nginx -n lambda -o yaml |grep "targetPort: 80" \
&& kubectl get svc nginx -n lambda -o yaml |grep selector: -A2 |grep "app: nginx" \
&& cat /tmp/lambda.log | grep "<h1>Welcome to nginx" \
&& kubectl get deploy nginx-deployment -n lambda -o yaml | grep "replicas: 6" \
&& systemctl status kubelet | grep running \
&& echo "done" 

