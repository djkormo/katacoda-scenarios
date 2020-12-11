**Network exercises**
# TODO IN DEVELOPMENT

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}


List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}



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


**To move to the next step make sure to have all checks with "done"**

```echo "done"```{{execute}}





