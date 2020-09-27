#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

kubectl create ns alpha

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/mysql-deployment.yaml -n alpha 

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/wordpress-deployment.yaml -n alpha 


https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-master-deployment.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-master-service.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-slave-deployment.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/redis-slave-service.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/frontend-deployment.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/guestbook/frontend-service.yaml -n alpha 