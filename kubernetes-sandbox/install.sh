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
apt-get install dnsutils -y >> /var/log/install
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

echo "done" >> /opt/.nodeupgraded
date >> /opt/.nodeupgraded

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
  "$KREW" install krew
)


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


## Installing metrics server 
git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log



# unistal flannel
#kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-old.yaml

# workaround for ds
kubectl delete ds/kube-flannel-ds-amd64 -n kube-system

# install calico

kubectl apply -f https://docs.projectcalico.org/v3.11/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

sleep 20

echo "done" >> /opt/.calico
date >> /opt/.calico

# installing nfs server

kubectl create ns nfs

k -n nfs apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-sandbox/nfs-server.yaml

## installing guestbook application 

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml









