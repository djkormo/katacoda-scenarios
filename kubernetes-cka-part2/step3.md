Scaling deployments 

All objects should by deployed into alpha namespace

**1.Create a deploy named nginx-deployment using image nginx:1.18.0 on port 80. Record the change**

CHECK
`kubectl get deploy nginx-deployment -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 
CHECK


**2.Expose deployment nginx-deployment named nginx-service using ClusterIP and port 80.**

CHECK
`kubectl get service nginx-service -n alpha -o yaml |grep "port: 80" && echo "done" `{{execute}} 
CHECK

**3.Change image in nginx-deployment to nginx:1.19.2 Record the change**

CHECK
`kubectl get deploy nginx-deployment -n alpha -o yaml |grep "image: nginx:1.19.2" && echo "done"`{{execute}}  

CHECK


**4.Rollback nginx-deployment to previous version**

CHECK
`kubectl get deploy nginx-deployment -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}}

`kubectl rollout history deploy/nginx-deployment -n alpha`{{execute}}

CHECK

**5.Scale deployment nginx-deployment to 5 replicas**

`kubectl get pod -n alpha -o  name -l app=nginx-deployment |wc -l | grep 5 && echo "done"`{{execute}}

**6. Use busybox image to get access to nginx webpage. Store the content to /var/answers/nginx.html**