Scaling deployments 

All objects should by deployed into **alpha** namespace


**1.Create a pod named nginx-pod-limit using image nginx:1.18.0 on port 80 add 200m CPU limit and 700Mi memory limit**
CHECK
`kubectl get pod nginx-pod-limit -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-limit -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-limit -o yaml -n alpha | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-limit -o yaml -n alpha | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-request using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request**

CHECK

`kubectl get pod nginx-pod-request -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**3.Create a pod named nginx-pod-request-limit using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

CHECK

`kubectl get pod nginx-pod-request-limit -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request-limit -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request-limit -o yaml -n alpha | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request-limit -o yaml -n alpha | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request-limit -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-request-limit -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**4.Create deployment  nginx-deployment-request-limit  using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

CHECK

`kubectl get deploy nginx-deployment-request-limit  -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get deploy nginx-deployment-request-limit  -o yaml -n alpha | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get deploy nginx-deployment-request-limit  -o yaml -n alpha | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

`kubectl get deploy nginx-deployment-request-limit  -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get deploy nginx-deployment-request-limit  -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**5.Expose deployment nginx-deployment-request-limit named nginx-service-request-limit using ClusterIP and port 80.**

CHECK
`kubectl get service nginx-service-request-limit -n alpha -o yaml |grep "port: 80" && echo "done" `{{execute}} 
CHECK