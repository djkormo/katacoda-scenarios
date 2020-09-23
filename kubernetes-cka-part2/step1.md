Pod and services exercises

This environment has a `launch.sh`{{execute}}

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.18 version

List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}

Create namespace alpha and ....

1. Create a pod named web using image nginx:1.19.9-alpine, on port 80 and 443. 


`kubectl get pod -n alpha`{{execute}}


2. Create a service to expose that pod, named as webservice

`kubectl get pod,svc,ep -n alpha`{{execute}}

3. List all the pods in alpha namespace sorted by name

