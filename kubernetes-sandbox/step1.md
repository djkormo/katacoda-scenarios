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

Let's upgrade 

`kubeadm upgrade apply v1.19.0`{{execute HOST1}}

`kubectl get nodes`{{execute HOST1}}

Now we have master node with 1.19 version and worked node with 1.18

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
Non-terminated Pods:          (6 in total)
  Namespace                   Name                         CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                   ----                         ------------  ----------  ---------------  -------------  ---
  default                     my-nginx-6b474476c4-4bpmx    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m36s
  default                     my-nginx-6b474476c4-ghxf7    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m36s
  default                     my-nginx-6b474476c4-llwqg    0 (0%)        0 (0%)      0 (0%)           0 (0%)         4m36s
  kube-system                 coredns-66bff467f8-h6q7l     100m (5%)     0 (0%)      70Mi (1%)        170Mi (4%)     6m58s
  kube-system                 kube-proxy-jtg29             0 (0%)        0 (0%)      0 (0%)           0 (0%)         5m14s
  kube-system                 kube-router-258xn            250m (12%)    0 (0%)      250Mi (6%)       0 (0%)         4m40s
</pre>

`kubectl drain node01 --ignore-daemonsets`{{execute HOST1}}

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

`ssh node01`{{execute HOST1}}

On node01 node

`apt-get update`{{execute}}

`apt-get install kubelet=1.19.0-00 -y `{{execute}}

`systemctl status kubelet`{{execute}}

`systemctl restart kubelet`{{execute}}


`systemctl status kubelet`{{execute}}

`exit`{{execute}}


On master node

`kubectl uncordon node01`{{execute}}

`kubectl get nodes`{{execute}}

`kubectl get pod -o wide`{{execute}}} 


To continue you should have 1.19 Kubernetes cluster with two nodes (ready)
