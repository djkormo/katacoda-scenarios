**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}


Inspect objects deployed in beta namespace

`kubectl get all,ep -n beta`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**


CHECK
`kubectl get svc frontend -n beta -o yaml |grep "nodePort: 30001" &&  echo "done"`{{execute}}
CHECK