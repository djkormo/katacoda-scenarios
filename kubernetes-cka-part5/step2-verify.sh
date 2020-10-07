#!/usr/bin/env bash

kubectl get pod webapp-volume-pvc -n vol -o yaml |grep " containerPort: 80"  \
  && kubectl get pod webapp-volume-pvc -n vol -o yaml  |grep 'image: nginx:latest' \
  && kubectl get pod webapp-volume-pvc -n vol |grep Running \
  && kubectl get pod webapp-volume-pvc -n vol -o yaml |grep "claimName: pvc-log" && echo "done" 
