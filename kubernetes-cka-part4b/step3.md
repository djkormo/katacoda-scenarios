# Troubleshooting exercises

Wait until deployments in **gamma** namespace appear

click ```clear```{{execute interrupt}} to begin

Show all namespaces

`kubectl get ns`{{execute}}


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


!
Inspect objects deployed in **gamma** namespace

`kubectl get all,ep -n gamma`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**


CHECK
`kubectl get svc frontend -n gamma -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n gamma -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}
`kubectl get svc frontend -n gamma -o yaml |grep selector: -A2 |grep "tier: frontend" && echo "done"`{{execute}}
CHECK


**To move to the next step make sure to have all checks with "done"**
