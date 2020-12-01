#!/usr/bin/env bash

#curl -sSf http://localhost:30001 > /tmp/alpha.log \
#&& kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" \
#&& cat /tmp/alpha.log | grep "<title>Guestbook</title>" \
#&&  echo "done"

kubectl get svc clusterip-nginx-service -n alpha -o yaml | grep "port: 3000" \
&& kubectl get ep clusterip-nginx-service -n alpha -o yaml | grep 8080 \
&& kubectl get deploy nginxx -n alpha | grep "1\/1" \
&& kubectl get pod fix-me -n alpha | grep "1\/1" &&  echo "done" \
&& echo "done"