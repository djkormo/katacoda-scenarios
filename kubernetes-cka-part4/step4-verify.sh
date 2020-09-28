#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/delta.log

kubectl get svc frontend -n delta -o yaml |grep "nodePort: 30001" \
&& kubectl get svc frontend -n delta -o yaml |grep "targetPort: 80" \
&& kubectl get svc frontend -n delta -o yaml |grep selector: -A2 |grep "tier: frontend" \
&& cat /tmp/delta.log | grep "<title>Guestbook</title>" \
&& echo "done" 

