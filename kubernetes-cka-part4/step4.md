**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}

![Guestbook architecture](./assets/guestbook-architecture.png)

Inspect objects deployed in delta namespace

`kubectl get all,ep -n delta`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/guestbook-web.png)

CHECK
`kubectl get svc frontend -n delta -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n delta -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}


`kubectl get deploy/redis-slave -n delta -o yaml |grep "containerPort: 6379"`{{execute}}
`kubectl get deploy/redis-master -n delta -o yaml |grep "containerPort: 6379"`{{execute}}

`kubectl get svc redis-slave -n delta -o yaml |grep "targetPort: 6379"`{{execute}}
`kubectl get svc redis-master -n delta -o yaml |grep "targetPort: 6379"`{{execute}}

CHECK