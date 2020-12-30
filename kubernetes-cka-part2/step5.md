Placing pods on proper nodes

`kubectl describe nodes | egrep "Name:|Taints:"`{{execute}}

<pre>
Name:               controlplane
Taints:             node-role.kubernetes.io/master:NoSchedule
Name:               node01
Taints:             <none>
</pre>

`kubectl get nodes --show-labels`{{execute}}

<pre>
NAME           STATUS   ROLES    AGE     VERSION   LABELS
controlplane   Ready    master   3m24s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/master=,whereareyou=master
node01         Ready    <none>   2m51s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux,whereareyou=worker
</pre>

All objects should by deployed into **beta** namespace.

Create **beta** namespace if needed


**1.Create a pod named nginx-pod-master-name using image nginx:1.18.0 on port 80. Deploy pod only on master node. Do not use taints and tolerations. Use node name**

CHECK

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-master-selector using image nginx:1.18.0 on port 80. Deploy pod only on node01 (worker) node. Do not use taints and tolerations. Use node selector**

Check labels on nodes. 



CHECK

`kubectl get pod nginx-pod-worker-selector -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n beta -o yaml | grep nodeSelector -A1 | grep whereareyou && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n beta -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n albetapha -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK

**3.Create a pod named nginx-pod-master-tolerations using image nginx:1.18.0 on port 80. Deploy pod only on master node. Use taints,tolerations and node selector.**


CHECK

`kubectl get pod nginx-pod-master-tolerations -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-tolerations -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-tolerations  -n beta -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Tolerations" && echo "done"`{{execute}}

`kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Node-Selectors" && echo "done"{{execute}}

CHECK

**4.Create a daemonset named nginx-ds using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit. Running on all cluster nodes.**

Remember to add resources


CHECK

`kubectl get daemonset nginx-ds -n beta  -o yaml |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -n beta -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -n beta -o yaml  | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -n beta -o yaml  | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n beta | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n beta | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**5.Create second scheduler on kubernetes cluster named my-scheduler using ports  insecure 54321  and secure 54322**

CHECK

`kubectl get pod -n kube-system -l component=kube-scheduler | grep my-scheduler && echo "done"`{{execute}} 

`kubectl get pod -n kube-system -l component=kube-scheduler| grep Running && echo "done"`{{execute}} 

`kubectl get pod -n kube-system --no-headers -l component=kube-scheduler| grep Running | wc -l | grep 2 && echo "done"`{
{execute}}

CHECK

**6.Create a deployment named nginx-deployment-my-scheduler using image nginx:1.18.0 on port 80 and my-scheduler scheduler**


CHECK

```kubectl get deploy nginx-deployment-my-scheduler -n beta```{{execute}}

```kubectl get deploy nginx-deployment-my-scheduler -n beta -o yaml | grep "schedulerName: my-scheduler"```{{execute}}

```kubectl get deploy nginx-deployment-my-scheduler -n beta --no-headers | grep "1/1" | wc -l | grep 1 && echo "done"`{{execute}}

CHECK

**7.Expose deployment nginx-deployment-my-scheduler named nginx-service-deployment-myscheduler using ClusterIP and port 80.**


CHECK

`kubectl get service nginx-service-deployment-my-scheduler -n beta`{{execute}}

`kubectl get ep nginx-service-deployment-my-scheduler -n beta | grep ":80"`{{execute}}

CHECK

**8.Create a deployment named nginx-deployment-all-nodes using image nginx:1.18.0 on port 80 running on all (two) nodes. Regadless replicas above number od nodes. Use affinity**

Set number of replicas = 5


CHECK 

`kubectl get deploy nginx-deployment-all-nodes -n beta`{{execute}}

`kubectl get pod -n beta -l app=nginx-deployment-all-nodes -o wide | grep "Running"`{{execute}}

`kubectl get pod -n beta -l app=nginx-deployment-all-nodes --no-headers |grep "Running" | wc -l`{{execute}}

CHECK


**To move to the next step make sure to have all checks with "done"**
