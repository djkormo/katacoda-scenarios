#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

kubectl create ns zeta

# based on 
# https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

kubectl delete deploy --all -n alpha
kubectl delete svc --all -n alpha

kubectl delete deploy --all -n beta
kubectl delete svc --all -n beta

kubectl delete deploy --all -n gamma
kubectl delete svc --all -n gamma

kubectl delete deploy --all -n delta
kubectl delete svc --all -n delta

kubectl delete deploy --all -n epsilon
kubectl delete svc --all -n epsilon

kubectl delete deploy --all -n zeta
kubectl delete svc --all -n zeta

sleep 10


# sed -i 's/kube-scheduler/kube-schedulerrr'/ /etc/kubernetes/manifests/kube-scheduler.yaml
sed -i 's/etc\/kubernetes\/pki/etc\/kubernetes\/pki-wrong/g' /etc/kubernetes/manifests/kube-controller-manager.yaml
sleep 10

#sed -i 's/etc\/kubernetes\/pki/etc\/kubernetes\/pki-wrong/g' /etc/kubernetes/manifests/kube-controller-manager.yaml
#systemctl stop kubelet

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step5/nginx-deployment.yaml -n zeta 
kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step5/nginx-service.yaml -n zeta 


sleep 10