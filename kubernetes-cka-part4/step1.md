# Troubleshooting exercises

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

`kubectl get all -o wide`{{execute}}


![Guestbook architecture](./assets/guestbook-architecture.png)


Inspect objects deployed in alpha namespace


`kubectl get all,ep -n alpha`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/guestbook-web.png)

CHECK
`kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" &&  echo "done"`{{execute}}
CHECK



**To move to the next step make sure to have all checks with "done"**
