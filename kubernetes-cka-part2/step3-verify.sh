#!/usr/bin/env bash


kubectl get deploy nginx-deployment -n alpha -o yaml |grep "containerPort: 80" \
  && kubectl get service nginx-service -n alpha -o yaml |grep "port: 80" \
  && kubectl rollout history deploy/nginx-deployment -n alpha --revision=2 | grep "nginx:1.19.2" \
  && kubectl rollout history deploy/nginx-deployment -n alpha --revision=3 | grep "nginx:1.18.0" \
  && kubectl get pod -n alpha -o  name -l app=nginx-deployment |wc -l | grep 5 \
  && echo "done"

