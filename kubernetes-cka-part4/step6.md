**Troubleshooting exercises**

Show all namespaces

`kubectl get ns`{{execute}}


Inspect objects deployed in zeta namespace

`kubectl get all,ep -n zeta`{{execute}}

Try to scale nginx-deployment deployment to 4 replicas


**Hint!**
Look at pods in kube-system namespace

**Try to fix kubernetes objects to see application in Application tab on 30001 port.**

![Web application](./assets/nginx-web.png)


CHECK
`kubectl get svc nginx -n zeta -o yaml |grep "nodePort: 30001" && kubectl get svc nginx -n zeta -o yaml |grep "targetPort: 80" && echo "done" `{{execute}}

`kubectl get pod -n kube-system |grep kube-controller-manager |grep Running && echo "done"`{{execute}}

`kubectl get deploy nginx-deployment -n lambda -o yaml | grep "replicas: 4" && echo "done"`{{execute}}

CHECK