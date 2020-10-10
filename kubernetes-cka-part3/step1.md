**Network exercises**


Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.18 version

Show all namespaces

`kubectl get ns`{{execute}}


List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}


**Optional**

Run weavescope to check cluster networking

`pod=$(kubectl get pod -n weave --selector=name=weave-scope-app -o jsonpath={.items..metadata.name})`{{execute}}

`kubectl expose pod $pod -n weave --name=weave-svc --external-ip=[[HOST_IP]] --port=4040 --target-port=4040 --dry-run=client -o yaml >weave-svc.yaml`{{execute}}

`kubectl apply -f weave-svc.yaml -n weave`{{execute}}

`kubectl get all,ep -n weave`{{execute}}


