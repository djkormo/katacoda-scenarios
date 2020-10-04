**Storage exercices**

Show list of cluster nodes

`kubectl get nodes`{{execute}}

Here we have cluster with 1.18 version

Show all namespaces

`kubectl get ns`{{execute}}

List all of pv and storage class 

`kubectl get sc,pv `{{execute}}

List all of pvc in vol namespace

`kubectl get pvc -o wide -n vol`{{execute}}




