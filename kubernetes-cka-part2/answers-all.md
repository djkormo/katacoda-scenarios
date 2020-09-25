1. run

`kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client > web-pod.yaml`{{copy}}


2. use

edit `vim web-pod.yaml`

add port 443

save 

3. deploy

`kubectl apply -f web-pod.yaml -n alpha`{{copy}}

`kubectl expose pod/web --name=webservice -n alpha`{{copy}}
