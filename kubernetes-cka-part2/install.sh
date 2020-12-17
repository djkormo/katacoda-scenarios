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

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
  "$KREW" install krew
) 


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" >> /opt/.krewinstall

echo "end" >> /opt/.krewinstall