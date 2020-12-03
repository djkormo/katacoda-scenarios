# Troubleshooting exercises

Wait until pods in **beta** namespace are deployed

click ```clear```{{execute interrupt}} to begin

Show all namespaces

`kubectl get ns`{{execute}}


Objects should be deployed in **beta** namespace

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




`kubectl get all,ep -n beta`{{execute}}


CHECK
`kubectl get svc frontend -n beta -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n beta -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}
CHECK


**To move to the next step make sure to have all checks with "done"**
