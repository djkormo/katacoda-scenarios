#!/usr/bin/env bash

mkdir -p /var/log/verify

kubectl get nodes | grep -v NAME | wc  -l > /var/log/verify/01-node-number.txt
cat 

kubectl get node -l node-role.kubernetes.io/master= |grep -v NAME | awk '{print$1}' > /var/log/verify/02-masternode-name.txt


echo "ens3" > /var/log/verify/06-network-interface.txt


master_node=$(kubectl get node -l node-role.kubernetes.io/master= -o name)

kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/verify/07-ip-master.txt

ip link show ens3 | awk '{print $2}' |grep -v ens3 > /var/log/verify/08-mac-master.txt

kubectl get node node01 -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/verify/09-ip-node01.txt

arp node01 -a $ipAddress | awk '{print $4}' > /var/log/verify/02-mac-node01.txt

echo "done" 
