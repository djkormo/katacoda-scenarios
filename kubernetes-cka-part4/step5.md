# Troubleshooting exercises 

Wait until pods in **epsilon** namespace are deployed

click ```clear```{{execute interrupt}} to begin

Show all namespaces

`kubectl get ns`{{execute}}


Inspect objects deployed in epsilon namespace

`kubectl get all,ep -n epsilon`{{execute}}


Try to deploy nginx pod to node01.

**Hint!**
Look at pods in kube-system namespace

**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/nginx-web.png)

CHECK
`kubectl get svc nginx -n epsilon -o yaml |grep "nodePort: 30001" && kubectl get svc nginx -n epsilon -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}

`kubectl get pod -n kube-system |grep kube-scheduler |grep Running && echo "done"`{{execute}}

CHECK


[ACCESS PORTS]({{TRAFFIC_SELECTOR}})

[ACCESS NGINX]({{TRAFFIC_HOST1_30001}})



**To move to the next step make sure to have all checks with "done"**



