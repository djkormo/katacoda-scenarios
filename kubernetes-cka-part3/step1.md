# Network exercises

# TODO IN DEVELOPMENT

**When all nodes are ready and version v1.19.0** 

<pre>
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   3m   v1.19.0
node01   Ready    worker   3m   v1.19.0
</pre>

click ```clear```{{execute interrupt}} to begin


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

Answer put in file /var/log/answers/ip-master

**2. What is MAC address assigned to node01?**

Answer put in file /var/log/answers/mac-node01

**3 What is the port the kube-scheduler is listening on in the master node**

Answer put in file /var/log/answers/kube-scheduler-port

**4 What is the port the kube-proxy is listening on in the node01 node**

Answer put in file /var/log/answers/kube-proxy-port

**5 What ports is the etcd listening on ?**

Answer put in file /var/log/answers/etcd-port

**6 What ports is the etcd listening on ?**
What is the network interface configured for cluster connectivity on the master node


**7 What ports is the etcd listening on ?**
What is the IP address assigned to the master node on its interface

**8 What ports is the etcd listening on ?**
What is the MAC address of the interface on the master node

**9 What ports is the etcd listening on ?**
What is the IP address assigned to node01

**10 What ports is the etcd listening on ?**
What is the MAC address assigned to node01




**To move to the next step make sure to have all checks with "done"**








