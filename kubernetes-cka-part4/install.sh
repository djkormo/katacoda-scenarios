#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


apt-get update >> /var/log/install
apt-get install kubeadm=1.24.0-00 kubectl=1.24.0-00 kubelet=1.24.0-00 -y  >> /var/log/install
systemctl restart kubelet  >> /var/log/install
kubeadm upgrade apply v1.24.0 -y  >> /var/log/install
systemctl restart kubelet  >> /var/log/install

echo "Upgrading cluster"
upgrade.sh
echo "done" >> /opt/.clusterupgraded
date >> /opt/.clusterupgraded

echo "Upgrading node"
ssh root@[[HOST2_IP]] "apt-get update && apt-get install kubeadm=1.24.0-00 kubelet=1.24.0-00 -y && systemctl restart kubelet"  >> /var/log/install

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

kubectl create ns alpha

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/mysql-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/wordpress-deployment.yaml -n alpha 


#https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-master-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-master-service.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-slave-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-slave-service.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/frontend-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/frontend-service.yaml -n alpha 


## Installing metrics server 
git clone https://github.com/vocon-it/metrics-server >>/var/log/step1-background.log
kubectl apply -f ./metrics-server/deploy/1.8+/ >>/var/log/step1-background.log
