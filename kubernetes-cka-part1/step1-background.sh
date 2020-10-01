

kubectl create ns alone

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part1/step1/alone-pod.yaml -n alone 

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part1/step1/web-server.yaml -n alone 

sleep 10
