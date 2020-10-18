#!/bin/bash
echo off
apt-get update && apt-get install kubeadm=1.18.0-00 kubelet 1.18.0-00 kubectl=1.18.0-00 -y && systemctl restart kubelet

ssh root@[[HOST2_IP]] "apt-get update && apt-get install kubeadm=1.18.0-00 kubelet=1.18.0-00 -y && systemctl restart kubelet"  >> /var/log/install

# Start Kubernetes
echo "Starting cluster"


source ~/.bashrc

echo "done" >> /opt/.clusterstarted