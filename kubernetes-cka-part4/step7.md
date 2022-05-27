* Troubleshooting exercises 


Wait until pods in **lambda** namespace are deployed

click ```clear```{{execute interrupt}} to begin

Show all namespaces

`kubectl get ns`{{execute}}

Shw nodes 
`kubectl get nodes`{{execute}}

Inspect objects deployed in lambda namespace

`kubectl get all,ep -n lambda`{{execute}}

Try to scale nginx-deployment deployment to 6 replicas

**Hint!**
Look at pods in kube-system namespace, Look at status of the nodes


**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/nginx-web.png)


CHECK
`kubectl get svc nginx -n lambda -o yaml |grep "nodePort: 30001" && kubectl get svc nginx -n lambda -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}

`kubectl get deploy nginx-deployment -n lambda -o yaml | grep "replicas: 6" && echo "done"`{{execute}}

`kubectl get pod -n lambda | grep nginx-deployment | grep Running && echo "done"`{{execute}}

`kubectl get deploy nginx-deployment -n lambda -o yaml | grep "replicas: 6" && echo "done"`{{execute}}

`systemctl status kubelet | grep running && echo "done"`{{execute}} 

`kubectl get pod -n lambda | grep nginx-deployment | grep Running  && echo "done"`{{execute}} 

CHECK


[ACCESS PORTS]({{TRAFFIC_SELECTOR}})

[ACCESS NGINX]({{TRAFFIC_HOST1_30001}})


**To move to the next step make sure to have all checks with "done"**
