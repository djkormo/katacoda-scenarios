# Troubleshooting exercises 

Wait until pods in **delta** namespace are deployed

click ```clear```{{execute interrupt}} to begin

Show all namespaces

`kubectl get ns`{{execute}}


Inspect objects deployed in **delta** namespace

`kubectl get all,ep -n delta`{{execute}}


CHECK
`kubectl get svc frontend -n delta -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n delta -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}


`kubectl get deploy/redis-slave -n delta -o yaml |grep "containerPort: 6379"`{{execute}}
`kubectl get deploy/redis-master -n delta -o yaml |grep "containerPort: 6379"`{{execute}}

`kubectl get svc redis-slave -n delta -o yaml |grep "targetPort: 6379"`{{execute}}
`kubectl get svc redis-master -n delta -o yaml |grep "targetPort: 6379"`{{execute}}

CHECK



**To move to the next step make sure to have all checks with "done"**
