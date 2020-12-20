Scaling deployments 

All objects should by deployed into **alpha** namespace

**1.Create a pod named nginx-pod-master using image nginx:1.18.0 on port 80. Deploy pod only on master node. Do not use taints and tolerations.**

CHECK
`kubectl get pod nginx-pod-master -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master  -n alpha -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master  -n alpha -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master  -n alpha -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-master-taints using image nginx:1.18.0 on port 80.Deploy pod only on master node. Use taints or tolerations.**

CHECK

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**3.Create a daemonset named nginx-ds using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit. Running on all cluster nodes.**

CHECK

`kubectl get daemonset nginx-ds -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**4.Create second scheduler on kubernetes cluster named my-scheduler using ports 54321  and 54322**

CHECK

`kubectl get pod -n kube-system -l component=kube-scheduler | grep my-scheduler && echo "done"`{{execute}} 

`kubectl get pod -n kube-system -l component=kube-scheduler| grep Running && echo "done"`{{execute}} 

CHECK

**5.Create a deployment named nginx-deployment-my-scheduler using image nginx:1.18.0 on port 80 and my-scheduler scheduler**

CHECK


CHECK


**6.Expose deployment nginx-deployment-my-scheduler named nginx-service-deployment using ClusterIP and port 80.**

CHECK


CHECK

**To move to the next step make sure to have all checks with "done"**
