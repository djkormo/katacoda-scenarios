## STEP 1


**1. What IP address is assigned to node01 node ?**


kubectl get node node01 -o wide 


echo "172.17.0.75" > /var/log/answers/ip-node1

cat /var/log/answers/ip-node1

Answer put in file /var/log/answers/ip-node1

**2. What is MAC address assigned to node01?**

Answer put in file /var/log/answers/mac-node01

arp node01

echo "02:42:ac:11:00:4b" > /var/log/answers/mac-node01

cat /var/log/answers/mac-node01

**3 What is the port the kube-scheduler is listening on in the master node**

Answer put in file /var/log/answers/kube-scheduler-port

netstat -npl | grep scheduler

echo "10259" > /var/log/answers/kube-scheduler-port

cat /var/log/answers/kube-scheduler-port

**4 What is the port the kube-proxy is listening on in the master node**

Answer put in file /var/log/answers/kube-proxy-port

netstat -npl | grep kube-proxy

echo "4040" > /var/log/answers/kube-proxy-port

cat /var/log/answers/kube-proxy-port

**5 What ports is the etcd listening on ?**

Answer put in file /var/log/answers/etcd-port

netstat -npl | grep etcd | grep 127.0.0.1

echo "2379" > /var/log/answers/etcd-port

cat /var/log/answers/etcd-port





# STEP 1


**01. What number of nodes we have (including master) ?**

Answer put in file /var/log/answers/01-node-number.txt

kubectl get nodes 
kubectl get nodes | grep -v NAME
kubectl get nodes | grep -v NAME | wc  -l
kubectl get nodes | grep -v NAME | wc  -l > /var/log/answers/01-node-number.txt
cat 


```cat /var/log/answers/01-node-number.txt.txt```{{execute}}

**02. What is the name of node master?**

Answer put in file /var/log/answers/02-masternode-name.txt

```
kubectl get node

kubectl get node -l node-role.kubernetes.io/master= -o name

kubectl get node -l node-role.kubernetes.io/master= |grep -v NAME | awk '{print$1}'

kubectl get node -l node-role.kubernetes.io/master= |grep -v NAME | awk '{print$1}' > /var/log/answers/02-masternode-name.txt

cat /var/log/answers/02-masternode-name.txt

```


**03 What is the port the kube-scheduler is listening on in the master node**


Answer put in file /var/log/answers/03-kube-scheduler-port.txt


netstat -nplt 
netstat -nplt | grep kube-schedule |
netstat -nplt | grep kube-schedule | grep -v tcp6
netstat -nplt | grep kube-schedule | grep -v tcp6 | awk '{print $4}' 
netstat -nplt | grep kube-schedule | grep -v tcp6 | awk '{print $4}' > /var/log/answers/03-kube-scheduler-port.txt

cat /var/log/answers/03-kube-scheduler-port.txt

**04 What is the port the kube-proxy is listening on in the node01 node**


Answer put in file /var/log/answers/04-kube-proxy-port.txt



**05 What ports is the etcd listening on ?**

Answer put in file /var/log/answers/05-etcd-port.txt

```


cat /var/log/answers/05-etcd-port.txt
```

**06 What is the network interface configured for cluster connectivity on the master node?**

Answer put in file /var/log/answers/06-network-interface.txt


```
ip link show ens3

echo "ens3" > /var/log/answers/06-network-interface.txt

cat /var/log/answers/06-network-interface.txt

```

**07 What is the IP address assigned to the master node on its interface ?**

Answer put in file /var/log/answers/07-ip-master.txt

```
master_node=$(kubectl get node -l node-role.kubernetes.io/master= -o name)

kubectl get $master_node -o wide

kubectl get $master_node -o wide | awk '{print $6}'

kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL

kubectl get $master_node -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/answers/07-ip-master.txt

cat /var/log/answers/07-ip-master.txt
```

**08 What is the MAC address of the interface on the master node ?**

Answer put in file /var/log/answers/08-mac-master.txt

```
ip link show ens3

ip link show ens3 | awk '{print $1}'

ip link show ens3 | awk '{print $2}' |grep -v ens3

ip link show ens3 | awk '{print $2}' |grep -v ens3 > /var/log/answers/08-mac-master.txt

cat /var/log/answers/08-mac-master.txt
```

**09 What is the IP address assigned to node01 ?**

Answer put in file /var/log/answers/09-ip-node01.txt

```
kubectl get node node01 -o wide

kubectl get node node01 -o wide | awk '{print $6}' 

kubectl get node node01 -o wide | awk '{print $6}' | grep -v INTERNAL

kubectl get node node01 -o wide | awk '{print $6}' | grep -v INTERNAL > /var/log/answers/09-ip-node01.txt
cat /var/log/answers/09-ip-node01.txt
```

**10 What is the MAC address assigned to node01 ?**

Answer put in file /var/log/answers/10-mac-node01.txt

```
arp node01

arp node01 -a $ipAddress | awk '{print $4}'

arp node01 -a $ipAddress | awk '{print $4}' > /var/log/answers/02-mac-node01.txt

cat /var/log/answers/10-mac-node01.txt
```

# STEP 2

**11. What is the IP address of the Default Gateway on master node ?**

Answer put in file /var/log/answers/11-mac-node01.txt


**12. Inspect the kubelet service and identify the network plugin configured for Kubernetes ?**

Answer put in file /var/log/answers/12-cni.txt

**13. What is the path configured with all binaries of CNI supported plugins**

Answer put in file /var/log/answers/13-path.txt

**14. What is the CNI plugin configured to be used on this kubernetes cluster**

Answer put in file /var/log/answers/14-cni-name.txt

**15. What is the Networking Solution used by this cluster**

Answer put in file /var/log/answers/15-networking.txt

**16. How many cni agents/peers are deployed in this cluster**

Answer put in file /var/log/answers/16-cni-agents.txt

**17. What is the range of IP addresses configured for PODs on this cluster**

Answer put in file /var/log/answers/17-pod-cidr.txt

**18. Identify the DNS solution implemented in this cluster**

Answer put in file /var/log/answers/18-dns-solution.txt

**19. How many pods of the DNS server are deployed**

Answer put in file /var/log/answers/19-dns-pods.txt

**20. What is the name of the service created for accessing DNS**

Answer put in file /var/log/answers/20-dns-service.txt


# STEP 3


**21. What is the IP of the DNS server that should be configured on PODs to resolve services**

Answer put in file /var/log/answers/21-dns-IP.txt

**22. Where is the configuration file located for configuring the DNS service**

Answer put in file /var/log/answers/22-dns-file.txt

**23. What is the name of the ConfigMap object created for Corefile**

Answer put in file /var/log/answers/23-dns-configmap.txt

**24. What is the root domain/zone configured for this kubernetes cluster?**

Answer put in file /var/log/answers/24-dns-zone.txt


# STEP 4 


TODO