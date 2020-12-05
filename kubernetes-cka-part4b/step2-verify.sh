#!/usr/bin/env bash

#curl -sSf http://localhost:30001 > /tmp/alpha.log \
#&& kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" \
#&& cat /tmp/alpha.log | grep "<title>Guestbook</title>" \
#&&  echo "done"
kubectl get pod configmap-pod -n beta | grep "0\/1" | grep "Completed" \
&& kubectl get pod secret-pod -n beta | grep "0\/1" | grep "Completed" \
&& echo "done"
