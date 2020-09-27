**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}


Inspect objects deployed in gamma namespace

`kubectl get all,ep -n gamma`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

CHECK
`kubectl get svc frontend -n gamma -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n gamma -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}
CHECK