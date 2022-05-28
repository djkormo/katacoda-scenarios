#!/bin/bash
echo off
apt-get update && apt-get install kubeadm=1.23.0-00 kubelet 1.23.0-00 kubectl=1.23.0-00 -y  >> /var/log/install
systemctl restart kubelet >> /var/log/install

ssh root@[[host2]] "apt-get update && apt-get install kubeadm=1.23.0-00 kubelet=1.23.0-00 -y && systemctl restart kubelet"  >> /var/log/install

# Start Kubernetes
echo "Starting cluster"

source ~/.bashrc

echo "done" >> /opt/.clusterstarted