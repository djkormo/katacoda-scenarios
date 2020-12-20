#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted


echo "start" >> /opt/.krewinstall
install-krew.sh >> /opt/.krewinstall
export PATH="${PATH}:${HOME}/.krew/bin" >> /opt/.krewinstall
echo "done" >> /opt/.krewinstall

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl create ns vol

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/storage-class.yaml

# kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/pv-local.yaml

# kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/pvc-local.yaml -n vol
