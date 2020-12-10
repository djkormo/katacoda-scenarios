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

