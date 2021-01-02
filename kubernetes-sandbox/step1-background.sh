#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted
date >> /opt/.clusterstarted

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}

source ~/.bashrc

apt-get update >> /var/log/install
apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y  >> /var/log/install
systemctl restart kubelet  >> /var/log/install
kubeadm upgrade apply v1.19.0 -y  >> /var/log/install
systemctl restart kubelet  >> /var/log/install

echo "Upgrading cluster"
upgrade.sh
echo "done" >> /opt/.clusterupgraded
date >> /opt/.clusterupgraded

echo "Upgrading node"
ssh root@[[HOST2_IP]] "apt-get update && apt-get install kubeadm=1.19.0-00 kubelet=1.19.0-00 -y && systemctl restart kubelet"  >> /var/log/install

echo "done" >> /opt/.nodeupgraded
date >> /opt/.nodeupgraded

echo "start" >> /opt/.krewinstall

install-krew.sh >> /opt/.krewinstall

export PATH="${PATH}:${HOME}/.krew/bin" >> /opt/.krewinstall

echo "done" >> /opt/.krewinstall

## Installing metrics server 
git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log

