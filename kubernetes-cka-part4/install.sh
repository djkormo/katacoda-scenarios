#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
#launch.sh
echo "done" >> /opt/.clusterstarted


#apt-get update >> /var/log/install
#apt-get install kubeadm=1.24.0-00 kubectl=1.24.0-00 kubelet=1.24.0-00 -y  >> /var/log/install
#systemctl restart kubelet  >> /var/log/install
#kubeadm upgrade apply v1.24.0 -y  >> /var/log/install
#systemctl restart kubelet  >> /var/log/install

echo "Upgrading cluster"
#upgrade.sh
echo "done" >> /opt/.clusterupgraded
date >> /opt/.clusterupgraded

echo "Upgrading node"
#ssh root@[[HOST2_IP]] "apt-get update && apt-get install kubeadm=1.24.0-00 kubelet=1.24.0-00 -y && systemctl restart kubelet"  >> /var/log/install

#echo "done" >> /opt/.nodeupgraded
#date >> /opt/.nodeupgraded

echo "done" >> /opt/.nodeupgraded
date >> /opt/.nodeupgraded

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


kubectl create namespace alpha --dry-run=client -o yaml | kubectl apply -f -

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


# Documented here 
# https://thospfuller.com/2020/11/29/easy-kubernetes-metrics-server-install-in-minikube-in-five-steps/

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f https://gist.githubusercontent.com/thospfuller/d0d918e0b9fdb719a34d3d355b0886bb/raw/63fefb2d1cf31563db04c60f036d6661b5ec5ff2/components.yaml

