#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/zeta.log

kubectl get svc frontend -n zeta -o yaml |grep "nodePort: 30001" \
&& kubectl get svc frontend -n zeta -o yaml |grep "targetPort: 80" \
&& kubectl get svc frontend -n zeta -o yaml |grep selector: -A2 |grep "tier: frontend" \
&& cat /tmp/zeta.log | grep "<h1>Welcome to nginx!</h1>" \
&& kubectl get pod -n kube-system |grep kube-scheduler |grep Running \
&& echo "done" 

