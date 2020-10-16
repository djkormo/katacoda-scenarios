**Troubleshooting exercises**


**When all nodes are `Ready with version 1.19`** 

click ```clear```{{execute interrupt}}


Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}

List all of objects in default namespace

`kubectl get all -o wide`{{execute}}


![Guestbook architecture](./assets/guestbook-architecture.png)


Inspect objects deployed in alpha namespace


`kubectl get all,ep -n alpha`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/guestbook-web.png)

CHECK
`kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" &&  echo "done"`{{execute}}
CHECK