Placing pods on proper nodes

```
kubectl describe nodes | egrep "Name:|Taints:"
```{{execute}}

Name:               controlplane
Taints:             node-role.kubernetes.io/master:NoSchedule
Name:               node01
Taints:             <none>


All objects should by deployed into **alpha** namespace


**1.Create a pod named nginx-pod-master-name using image nginx:1.18.0 on port 80. Deploy pod only on master node. Do not use taints and tolerations. Use node name**

```
kubectl run nginx-pod-master-name -n alpha --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-name.yaml

vim 05-nginx-pod-master-name.yaml
```
add 
nodeName: controlplane
save file

```
kubectl apply -f 05-nginx-pod-master-name.yaml
kubectl get pod nginx-pod-master-name -n alpha -o wide
```

<pre>
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx-pod-master-name   1/1     Running   0          17s   10.244.0.5   controlplane   <none>           <none>

</pre>

CHECK

`kubectl get pod nginx-pod-master-name -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n alpha -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n alpha -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n alpha -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-master-selector using image nginx:1.18.0 on port 80. Deploy pod only on master (cntrolplane) node. Do not use taints and tolerations. Use node selector**

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
kubectl run nginx-pod-master-selector -n alpha --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-selector.yaml

vim 05-nginx-pod-master-selector.yaml
```
add 
  nodeSelector:
    whereareyou: master

save file

```
kubectl apply -f 05-nginx-pod-master-selector.yaml
kubectl get pod nginx-pod-master-selector -n alpha -o wide
kubectl describe pod nginx-pod-master-selector -n alpha
```
<pre>
  ...
  Node-Selectors:  whereareyou=master
  ...
  Warning  FailedScheduling  24s         0/2 nodes are available: 1 node(s) didn't match node selector, 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
  ...
</pre>


CHECK

`kubectl get pod nginx-pod-master-selector -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-selector -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-selector  -n alpha -o yaml | grep nodeSelector -A1 | grep whereareyou && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-selector  -n alpha -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-selector  -n alpha -o wide | grep -v -i toleration && echo "done"`{{execute}} 


CHECK


**3.Create a pod named nginx-pod-master-tolerations using image nginx:1.18.0 on port 80.Deploy pod only on master node. Use taints or tolerations.**



```
kubectl run nginx-pod-master-tolerations -n alpha --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-tolerations.yaml

vim 05-nginx-pod-master-tolerations.yaml
```
add 
  tolerations:
  - key: "myKey"
    operator: "Equal"
    value: "myValue"
    effect: "NoSchedule"
    
save file

```


CHECK

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-taints -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**4.Create a daemonset named nginx-ds using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit. Running on all cluster nodes.**

CHECK

`kubectl get daemonset nginx-ds -o yaml -n alpha |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -n alpha -o yaml |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep limits: -A2 | grep "cpu: 200m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep limits: -A2 | grep "memory: 700Mi" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep requests: -A2 | grep "cpu: 100m" && echo "done"`{{execute}} 

`kubectl get daemonset nginx-ds -o yaml -n alpha | grep requests: -A2 | grep "memory: 500Mi" && echo "done"`{{execute}} 

CHECK

**5.Create second scheduler on kubernetes cluster named my-scheduler using ports 54321  and 54322**

CHECK

`kubectl get pod -n kube-system -l component=kube-scheduler | grep my-scheduler && echo "done"`{{execute}} 

`kubectl get pod -n kube-system -l component=kube-scheduler| grep Running && echo "done"`{{execute}} 

CHECK

**6.Create a deployment named nginx-deployment-my-scheduler using image nginx:1.18.0 on port 80 and my-scheduler scheduler**

CHECK


CHECK


**6.Expose deployment nginx-deployment-my-scheduler named nginx-service-deployment using ClusterIP and port 80.**

CHECK


CHECK

**To move to the next step make sure to have all checks with "done"**
