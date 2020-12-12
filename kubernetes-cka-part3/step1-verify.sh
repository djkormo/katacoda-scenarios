#!/usr/bin/env bash
master_node=$(kubectl get node -l node-role.kubernetes.io/master= -o name)

kubectl get $master_node -o wide
kubectl get $master_node -o wide | awk '{print $6}'
kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL
kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/answers/07-ip-master.txt

cat /var/log/answers/07-ip-master.txt

echo "done" 
