#!/usr/bin/env bash
curl -sSf http://localhost:30001 > /tmp/gamma.log

kubectl get svc frontend -n gamma -o yaml |grep "nodePort: 30001" \
&& kubectl get svc frontend -n gamma -o yaml |grep "targetPort: 80" \
&& kubectl get svc frontend -n gamma -o yaml |grep selector: -A2 |grep "tier: frontend" \
&& cat /tmp/gamma.log | grep "<title>Guestbook</title>" \
&& echo "done" 
