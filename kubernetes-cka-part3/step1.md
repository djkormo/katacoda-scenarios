**Network exercises**


**When all nodes are `Ready with version 1.19`** 

click ```clear```{{execute interrupt}}



Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

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


**1. What IP address is assigned to node01 node ?**

Answer put in file /var/log/answers/ip-masnode01ter

**2. What is MAC address assigned to node01?**

Answer put in file /var/log/answers/mac-node01

**3 What is the port the kube-scheduler is listening on in the master node**

Answer put in file /var/log/answers/kube-scheduler-port

**4 What is the port the kube-proxy is listening on in the node01 node**

Answer put in file /var/log/answers/kube-proxy-port

**5 What ports is the etcd listening on ?**

Answer put in file /var/log/answers/etcd-port







