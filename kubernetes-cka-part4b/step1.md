# Troubleshooting exercises

**When all nodes are ready and version is v1.19.x** 

<pre>
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   3m   v1.19.0
node01   Ready    worker   3m   v1.19.0
</pre>



Wait until pods in **alpha** namespace are deployed

click ```clear```{{execute interrupt}} to begin

There're two broken pods.

Also, try to create this service which won't start:

`cat clusterip-service.yml;echo`{{execute}}

**Remember** - In order to troubleshoot you want to use some of these followings k8s commands:

```
kubectl describe deployment/<deployname>
kubectl describe replicaset/<rsname>
kubectl get pods
kubectl get deployments
kubectl get replicaset
kubectl describe pod/<podname>
kubectl logs <podname> --previous
kubectl get events
```

[**k8s cheatsheet**](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)


CHECK
`kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" &&  echo "done"`{{execute}}
CHECK



**To move to the next step make sure to have all checks with "done"**
