#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}

source ~/.bashrc


apt-get update
apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y
systemctl restart kubelet
kubeadm upgrade apply v1.19.0 -y
systemctl restart kubelet


echo "Upgrading cluster"
launch.sh
echo "done" >> /opt/.clusterupgraded

ssh node01

apt-get update
apt-get install kubeadm=1.19.0-00 kubelet=1.19.0-00 -y
systemctl restart kubelet

