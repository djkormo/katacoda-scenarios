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

`kubectl get nodes`{{execute}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}


List all of objects in default namespace

`kubectl get all -o wide`{{execute}}


**Optional**

Run weavescope to check cluster networking

`pod=$(kubectl get pod -n weave --selector=name=weave-scope-app -o jsonpath={.items..metadata.name})`{{execute}}

`kubectl expose pod $pod -n weave --name=weave-svc --external-ip=[[HOST_IP]] --port=4040 --target-port=4040 --dry-run=client -o yaml >weave-svc.yaml`{{execute}}

`kubectl apply -f weave-svc.yaml -n weave`{{execute}}

`kubectl get all,ep -n weave`{{execute}}


## Let's begin!


**01. What number of nodes we have (including master) ?**

Answer put in file /var/log/answers/01-node-number.txt


```cat /var/log/answers/01-node-number.txt.txt```{{execute}}

**02. What is the name of node master?**

Answer put in file /var/log/answers/02-masternode-name.txt


```cat /var/log/answers/02-masternode-name.txt```{{execute}}

**03 What is the port the kube-scheduler is listening on in the master node**

Answer put in file /var/log/answers/03-kube-scheduler-port.txt

```cat /var/log/answers/03-kube-scheduler-port```{{execute}}

**04 What is the port the kube-proxy is listening on in the node01 node**

Answer put in file /var/log/answers/04-kube-proxy-port.txt

**05 What ports is the etcd listening on ?**

```cat /var/log/answers/04-kube-proxy-port.txt```{{execute}}

Answer put in file /var/log/answers/05-etcd-port.txt

```cat /var/log/answers/05-etcd-port.txt```{{execute}}

**06 What is the network interface configured for cluster connectivity on the master node?**

Answer put in file /var/log/answers/06-network-interface.txt

```cat /var/log/answers/06-network-interface```{{execute}}

**07 What is the IP address assigned to the master node on its interface ?**

Answer put in file /var/log/answers/07-ip-master.txt

```cat /var/log/answers/07-ip-master.txt```{{execute}}

**08 What is the MAC address of the interface on the master node ?**

Answer put in file /var/log/answers/08-mac-master.txt

```cat /var/log/answers/08-mac-master```{{execute}}

**09 What is the IP address assigned to node01 ?**

Answer put in file /var/log/answers/09-ip-node01.txt

```cat /var/log/answers/09-ip-node01.txt```{{execute}}

**10 What is the MAC address assigned to node01 ?**

Answer put in file /var/log/answers/10-mac-node01.txt


```cat /var/log/answers/10-mac-node01.txt```{{execute}}

```echo "done"```{{execute}}



**To move to the next step make sure to have all checks with "done"**








