**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}

Shw nodes 
`kubectl get nodes`{{execute}}

Inspect objects deployed in lambda namespace

`kubectl get all,ep -n lambda`{{execute}}

Try to scale nginx deployment to 6 replicas

**Hint!**
Look at pods in kube-system namespace, Look at status of the nodes


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

CHECK
`kubectl get svc nginx -n lambda -o yaml |grep "nodePort: 30001" && kubectl get svc nginx -n lambda -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}

CHECK