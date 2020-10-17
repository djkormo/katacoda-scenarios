#!/bin/bash
echo off
apt-get update


# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


mkdir -p /var/log/answers/


# create a vimrc
cat <<EOF >>.vimrc
" Created on $(date)
set nocompatible
syntax enable
filetype plugin indent on
set paste
set tabstop=2
set autoindent
EOF


kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part3/step1/weavescope-deploy.yaml -n weave
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part3/step1/weavescope-service.yaml -n weave


pod=$(kubectl get pod -n weave --selector=name=weave-scope-app -o jsonpath={.items..metadata.name})

kubectl expose pod $pod -n weave --name=weave-svc --external-ip=[[HOST_IP]] --port=4040 --target-port=4040