**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}

![Guestbook architecture](./assets/guestbook-architecture.png)

Inspect objects deployed in gamma namespace

`kubectl get all,ep -n gamma`{{execute}}


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/guestbook-web.png)

CHECK
`kubectl get svc frontend -n gamma -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n gamma -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}
`kubectl get svc frontend -n gamma -o yaml |grep selector: -A2 |grep "tier: frontend" && echo "done"`{{execute}}
CHECK