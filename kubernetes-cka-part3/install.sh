#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


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


curl -L https://cloud.weave.works/launch/k8s/weavescope.yaml

kubectl apply -f https://cloud.weave.works/launch/k8s/weavescope.yaml

pod=$(kubectl get pod -n weave --selector=name=weave-scope-app -o jsonpath={.items..metadata.name})

kubectl expose pod $pod -n weave --external-ip="172.17.0.34" --port=4040 --target-port=4040

