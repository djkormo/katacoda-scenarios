

kubectl create ns alone

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-master-deployment.yaml -n alone 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part4/step1/redis-master-service.yaml -n alone 

sleep
