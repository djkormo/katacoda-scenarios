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

# Adding storage class
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/storage-class.yaml


## installing guestbook application 

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml

kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml

#kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step2/frontend-service.yaml

kubectl patch svc/frontend --patch \
  '{"spec": { "type": "NodePort", "ports": [ { "nodePort": 30001, "port": 80, "protocol": "TCP", "targetPort": 80 } ] } }'


#kubectl expose deploy/frontend -n default --name=frontend  --external-ip=[[HOST_IP]] --port=8080 --target-port=8080




