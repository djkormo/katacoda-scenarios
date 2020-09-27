#!/usr/bin/env bash

curl -sSf http://localhost:30001 > /tmp/beta.log

kubectl get svc frontend -n beta -o yaml |grep "nodePort: 30001" \
&& kubectl get svc frontend -n beta -o yaml |grep "targetPort: 80" \
&& cat /tmp/beta.log | grep "<title>Guestbook</title>" \
&& echo "done" 
