**Network exercises**

# TODO IN DEVELOPMENT

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}


List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}


**21. What is the IP of the DNS server that should be configured on PODs to resolve services**

Answer put in file /var/log/answers/21-dns-IP.txt

**22. Where is the configuration file located for configuring the DNS service**

Answer put in file /var/log/answers/22-dns-file.txt

**23. What is the name of the ConfigMap object created for Corefile**

Answer put in file /var/log/answers/23-dns-configmap.txt

**24. What is the root domain/zone configured for this kubernetes cluster?**

Answer put in file /var/log/answers/24-dns-zone.txt


```echo "done"```{{execute}}

**To move to the next step make sure to have all checks with "done"**





