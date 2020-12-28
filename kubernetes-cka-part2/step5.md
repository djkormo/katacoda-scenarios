Placing pods on proper nodes

``` 
kubectl describe nodes | egrep "Name:|Taints:"
```{{execute}}

<pre>
Name:               controlplane
Taints:             node-role.kubernetes.io/master:NoSchedule
Name:               node01
Taints:             <none>
</pre>

``` 
kubectl get nodes --show-labels
```{{execute}}
<pre>
NAME           STATUS   ROLES    AGE     VERSION   LABELS
controlplane   Ready    master   3m24s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/master=,whereareyou=master
node01         Ready    <none>   2m51s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux,whereareyou=worker
<pre>

All objects should by deployed into **beta** namespace.

Create **beta** names space if is missing


**1.Create a pod named nginx-pod-master-name using image nginx:1.18.0 on port 80. Deploy pod only on master node. Do not use taints and tolerations. Use node name**

```
kubectl run nginx-pod-master-name -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-name.yaml
```

edit

```
vim 05-nginx-pod-master-name.yaml
```
add 
nodeName: controlplane
save file

```
kubectl apply -f 05-nginx-pod-master-name.yaml
```

```
kubectl get pod nginx-pod-master-name -n beta -o wide
```
<pre>
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx-pod-master-name   1/1     Running   0          17s   10.244.0.5   controlplane   <none>           <none>

</pre>

CHECK

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-master-selector using image nginx:1.18.0 on port 80. Deploy pod only on node01 (worker) node. Do not use taints and tolerations. Use node selector**

Check labels on nodes. 

# kubectl label node controlplane whereareyou=master
# kubectl label node node01 whereareyou=worker
# kubectl taint node controlplane myKey=myValue:NoSchedule
# kubectl taint node node01 myKey=myValue:NoSchedule

k get nodes --show-labels
<pre>
NAME           STATUS   ROLES    AGE   VERSION   LABELS

controlplane   Ready    master   32m   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/master=,whereareyou=master

node01         Ready    <none>   32m   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux,whereareyou=worker
</pre>

```
kubectl run nginx-pod-worker-selector -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-worker-selector.yaml
```

edit

```
vim 05-nginx-pod-worker-selector.yaml
```

add 
  nodeSelector:
    whereareyou: worker

save file

```
kubectl apply -f 05-nginx-pod-worker-selector.yaml
kubectl get pod nginx-pod-worker-selector -n beta -o wide
kubectl describe pod nginx-pod-worker-selector -n beta | grep "Node-Selectors"
```
<pre>
  ...
  Node-Selectors:  whereareyou=worker
  ...
Events:
  Type    Reason     Age   From             Message
  ----    ------     ----  ----             -------
  Normal  Scheduled  10s                    Successfully assigned alpha/nginx-pod-worker-selector to node01
  ...
</pre>


CHECK

`kubectl get pod nginx-pod-worker-selector -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n beta -o yaml | grep nodeSelector -A1 | grep whereareyou && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n beta -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-worker-selector  -n albetapha -o wide | grep -v -i toleration && echo "done"`{{execute}} 


CHECK


**3.Create a pod named nginx-pod-master-tolerations using image nginx:1.18.0 on port 80.Deploy pod only on master node. Use taints,tolerations and node selector.**



```
kubectl run nginx-pod-master-tolerations -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-tolerations.yaml

edit

```
vim 05-nginx-pod-master-tolerations.yaml
```
add
```yaml 
  tolerations:
  - key: "node-role.kubernetes.io/master"
    effect: "NoSchedule"
  nodeSelector:
    whereareyou: master
```
save file

```
kubectl apply -f  05-nginx-pod-master-tolerations.yaml 
```

```
kubectl get pod nginx-pod-master-tolerations -n beta -o wide
kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Tolerations"
kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Node-Selectors"
```

<pre>
Tolerations:     node-role.kubernetes.io/master:NoSchedule
Node-Selectors:  whereareyou=master

Events:
  Type    Reason     Age   From                   Message
  ----    ------     ----  ----                   -------
  Normal  Scheduled  3m1s                         Successfully assigned beta/nginx-pod-master-tolerations tocontrolplane
  Normal  Pulled     3m1s  kubelet, controlplane  Container image "nginx:1.18.0" already present on machine
  Normal  Created    3m    kubelet, controlplane  Created container nginx-pod-master-tolerations
  Normal  Started    3m    kubelet, controlplane  Started container nginx-pod-master-tolerations
<pre>

CHECK

`kubectl get pod nginx-pod-master-tolerations -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-tolerations -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-tolerations  -n beta -o wide | grep controlplane && echo "done"`{{execute}} 
`kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Tolerations" && echo "done"`{{execute}}
`kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Node-Selectors" && echo "done"{{execute}}

CHECK

**4.Create a daemonset named nginx-ds using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit. Running on all cluster nodes.**

```
kubectl create  deployment  nginx-ds --image=nginx:1.18.0 --namespace=beta --port=80 -o yaml --dry-run=client > 05-ds-nginx-limits-resources.yaml

```
edit

```
 vim 05-ds-nginx-limits-resources.yaml
```
change Deployment to DaemonSet
remove replicas, strategy and statua

```
kubectl apply -f 05-ds-nginx-limits-resources.yaml
```

```
kubectl get pod -n beta -o wide | grep nginx-ds
```
<pre>
nginx-ds-h4z7m                 1/1     Running   0          116s   10.244.1.8   node01         <none>   <none>
</pre>

Why is not running on controlplane (master) node ?

 vim 05-ds-nginx-limits-resources.yaml

 add toleration 

```
kubectl get pod -n beta -o wide | grep nginx-ds
```
<pre>
nginx-ds-frwmm                 1/1     Running   0          5s    10.244.1.9   node01         <none>  <none>
nginx-ds-th7dd                 1/1     Running   0          17s   10.244.0.6   controlplane   <none>  <none>
</pre>

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

```
kubectl get pod -n kube-system -l component=kube-scheduler
```
<pre>
NAME                          READY   STATUS    RESTARTS   AGE
kube-scheduler-controlplane   1/1     Running   0          33m
</pre>

Now we have static pod (-nodename as suffix)
```
cp /etc/kubernetes/manifests/kube-scheduler.yaml /tmp/my-scheduler.yaml
```
vim /tmp/my-scheduler.yaml

change name to my-scheduler

and add like below

- --leader-elect=false
- --port=54321
- --secure-port=54322
- --scheduler-name=my-scheduler

remember to change port for liveness and readiness to secure-port number

```
cp /tmp/my-scheduler.yaml /etc/kubernetes/manifests/
```
```
kubectl describe my-scheduler-controlplane -n kube-system
kubectl logs my-scheduler-controlplane -n kube-system
```

CHECK

`kubectl get pod -n kube-system -l component=kube-scheduler | grep my-scheduler && echo "done"`{{execute}} 

`kubectl get pod -n kube-system -l component=kube-scheduler| grep Running && echo "done"`{{execute}} 

`kubectl get pod -n kube-system --no-headers -l component=kube-scheduler| grep Running | wc -l | grep 2 && echo "done"`{{execute}}

CHECK

**6.Create a deployment named nginx-deployment-my-scheduler using image nginx:1.18.0 on port 80 and my-scheduler scheduler**

```
kubectl create  deployment  nginx-deployment-my-scheduler --image=nginx:1.18.0  --namespace=beta --port=80 -o yaml --dry-run=client > 05-deploy-nginx-my-scheduler.yaml

vim 05-deploy-nginx-my-scheduler.yaml

add

schedulerName: my-scheduler

kubectl apply -f  05-deploy-nginx-my-scheduler.yaml



CHECK
kubectl get deploy nginx-deployment-my-scheduler -n beta

CHECK

**6.Expose deployment nginx-deployment-my-scheduler named nginx-service-deployment-myscheduler using ClusterIP and port 80.**

```
kubectl expose deploy/nginx-deployment-my-scheduler -n beta --name nginx-service-deployment-my-scheduler -o yaml --dry-run=client > 05-service-deploy-nginx-my-scheduler.yaml
```

vim 05-service-deploy-nginx-my-scheduler.yaml

add 
namespace: beta


kubectl apply -f 05-service-deploy-nginx-my-scheduler.yaml

CHECK
kubectl get service nginx-service-deployment-my-scheduler -n beta

CHECK

**To move to the next step make sure to have all checks with "done"**
