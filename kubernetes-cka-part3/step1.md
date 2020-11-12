# Network exercises


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


What is the network interface configured for cluster connectivity on the master node

What is the IP address assigned to the master node on its interface

What is the MAC address of the interface on the master node

What is the IP address assigned to node01

What is the MAC address assigned to node01

What is the IP address of the Default Gateway on master node

Inspect the kubelet service and identify the network plugin configured for Kubernetes

What is the path configured with all binaries of CNI supported plugins

What is the CNI plugin configured to be used on this kubernetes cluster

What is the Networking Solution used by this cluster

How many cni agents/peers are deployed in this cluster

What is the range of IP addresses configured for PODs on this cluster


Identify the DNS solution implemented in this cluster

How many pods of the DNS server are deployed

What is the name of the service created for accessing DNS

What is the IP of the DNS server that should be configured on PODs to resolve services

Where is the configuration file located for configuring the DNS service

What is the name of the ConfigMap object created for Corefile

What is the root domain/zone configured for this kubernetes cluster?


**To move to the next step make sure to have all checks with "done"**








