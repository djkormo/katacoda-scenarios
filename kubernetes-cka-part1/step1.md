Upgrade cluster from version 1.18 to 1.19

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.18 version

List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}

Out goal is to have running 1.19 version cluster.

`kubectl version --short 
kubeadm version -o short
kubelet --version
`{{execute}}

Update packages

`apt-get update`{{execute HOST1}}

Install specific version of  kubeadm, kubelet and kubectl

`apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y`{{execute HOST1}}

What upgrade plan is possible ?

`kubeadm upgrade plan`{{execute HOST1}}

Let's upgrade (remember to confirm by pressing y key) 

`kubeadm upgrade apply v1.19.0`{{execute HOST1}}

Let's see the cluster nodes

`kubectl get nodes`{{execute HOST1}}

Now we have master node with 1.19 version and worker node with 1.18

**Look what deployment and pods are on our cluster. Preserve them**


The first thing is to detach worker node from kubernetes cluster.

`kubectl drain node01`{{execute HOST1}}

<pre>
node/node01 cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
error: cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-system/kube-proxy-chm2m, kube-system/kube-router-ssqcq
</pre>

List all pods running on node01

`kubectl describe node node01 |grep Non-terminated -A 8`{{execute}}

<pre>
Non-terminated Pods:          (8 in total)
  Namespace                   Name                         CPU Requests  CPU Limits  Memory Requests  MemoryLimits  AGE
  ---------                   ----                         ------------  ----------  ---------------  -------------  ---
  alone                       alone-pod                    0 (0%)        0 (0%)      0 (0%)           0 (0%)        3m2s
  alone                       web-server                   0 (0%)        0 (0%)      0 (0%)           0 (0%)        3m2s
  default                     my-nginx-6b474476c4-2l4cf    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  default                     my-nginx-6b474476c4-mkkz2    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  default                     my-nginx-6b474476c4-mvxg6    0 (0%)        0 (0%)      0 (0%)           0 (0%)        9m35s
  kube-system                 coredns-f9fd979d6-b2qsx      100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     5m28s
</pre>

**Look what deployment and pods are on our cluster. Preserve them**


`kubectl drain node01 --ignore-daemonsets`{{execute HOST1}}

<pre>
node/node01 already cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
error: cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): alone/alone-pod, alone/web-server
</pre>

node/node01 already cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
error: cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): alone/alone-pod, alone/web-server

`kubectl get pod -n alone`{{execute}}
Preserve the alone pods

`kubectl get pod/alone-pod -n alone -o yaml >pod-alone-alone-pod.yaml`{{execute}}
`kubectl get pod/web-server -n alone -o yaml >pod-alone-web-server.yaml`{{execute}}

`kubectl drain node01 --ignore-daemonsets --force `{{execute HOST1}}

<pre>
node/node01 already cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-pz94c, kube-system/kube-router-brhfw
evicting pod default/my-nginx-6b474476c4-6rq86
evicting pod default/my-nginx-6b474476c4-tcswf
evicting pod default/my-nginx-6b474476c4-wqr6d
pod/my-nginx-6b474476c4-tcswf evicted
pod/my-nginx-6b474476c4-wqr6d evicted
pod/my-nginx-6b474476c4-6rq86 evicted
node/node01 evicted
</pre>

**Look what deployment and pods are on our cluster. Preserve them**

`ssh node01`{{execute HOST1}}

On node01 node

`apt-get update`{{execute}}

`apt-get install kubelet=1.19.0-00 -y `{{execute}}

Now we should restart kubelet
`systemctl restart kubelet`{{execute}}



On master node

`kubectl uncordon node01`{{execute}}

`kubectl get nodes`{{execute}}

`kubectl get pod -o wide`{{execute}}} 


To continue you should have 1.19 Kubernetes cluster with two nodes (ready)
