# Troubleshooting exercises

**When all nodes are ready and version is v1.19.x** 

<pre>
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   3m   v1.19.0
node01   Ready    worker   3m   v1.19.0
</pre>


click ```clear```{{execute interrupt}} to begin

Check /manifests directory

Deploy nginx-deployment.yaml and clusterip.service.yaml

`cat /manifests/nginx-deployment.yaml;echo`{{execute}}
`cat /manifests/clusterip-service.yaml;echo`{{execute}}

Objects should be in alpha namespace


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


`kubectl get all,ep -n alpha`{{execute}}


**All** pods should be ready and running. Endpoint for service should be exposed.


CHECK
`kubectl get svc clusterip-nginx-service -n alpha -o yaml | grep "port: 3000" &&  echo "done"`{{execute}}
`kubectl get ep clusterip-nginx-service -n alpha -o yaml | grep 8080  &&  echo "done"`{{execute}}
`kubectl get deploy nginxx -n alpha | grep "1\/1" &&  echo "done"`{{execute}}
`kubectl get pod fix-me -n alpha | grep "1\/1" &&  echo "done"`{{execute}}
CHECK


**To move to the next step make sure to have all checks with "done"**
