#!/usr/bin/env bash
master_node=$(kubectl get node -l node-role.kubernetes.io/master= -o name)

kubectl get $master_node -o wide
kubectl get $master_node -o wide | awk '{print $6}'
kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL
kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/verify/07-ip-master.txt


ip link show ens3
ip link show ens3 | awk '{print $1}'
ip link show ens3 | awk '{print $2}' |grep -v ens3
ip link show ens3 | awk '{print $2}' |grep -v ens3 > /var/log/verify/08-mac-master.txt

echo "done" 
