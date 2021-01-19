

**When all nodes are ready and version v1.19.x** 

<pre>
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   3m   v1.19.0
node01   Ready    worker   3m   v1.19.0
</pre>

click ```clear```{{execute interrupt}} to begin

Lets try to control remainning time to reset our sandbox

<pre>
58 min root@master
</pre>

It means that you have only 58 minutes to finish the lab!!

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}

List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}

Sample application

https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

is installed in **default** namespace


Check all objects 

`kubectl get all,ep`{{execute}}


Check events 

`kubectl get events -n default --sort-by=.metadata.creationTimestamp`{{execute}}


Look for CNI - here we have calico

`kubectl get pod -n kube-system`{{execute}}
<pre>
NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-6b8f6f78dc-2f2z4   1/1     Running   0          4m26s
calico-node-kd698                          1/1     Running   0          4m25s
calico-node-m4zl6                          1/1     Running   0          4m26s
coredns-f9fd979d6-9495l                    1/1     Running   0          4m25s
coredns-f9fd979d6-mgb6h                    1/1     Running   0          4m26s
etcd-controlplane                          1/1     Running   0          5m18s
katacoda-cloud-provider-58f89f7d9-fdbrr    1/1     Running   4          7m42s
kube-apiserver-controlplane                1/1     Running   0          5m10s
kube-controller-manager-controlplane       1/1     Running   0          5m1s
kube-keepalived-vip-qz98w                  1/1     Running   0          6m27s
kube-proxy-dlqv4                           1/1     Running   0          4m9s
kube-proxy-mq6d9                           1/1     Running   0          4m15s
kube-scheduler-controlplane                1/1     Running   0          4m59s
metrics-server-85f8dd85fd-f762r            1/1     Running   0          6m27s
</pre>


Learn more and more

https://learnk8s.io/blog/kubectl-productivity

Have fun !

Optionally you can configure bash completion


`cat ~/.bashrc`{{execute}}

`apt-get install bash-completion`{{execute}}

`source /usr/share/bash-completion/bash_completion`{{execute}}

`echo 'source <(kubectl completion bash)' >>~/.bashrc`{{execute}}

`echo 'alias k=kubectl' >>~/.bashrc`{{execute}}

`echo 'complete -F __start_kubectl k' >>~/.bashrc`{{execute}}

Reload shell

`source ~/.bashrc`{{execute}}

https://kubernetes.io/docs/tasks/tools/install-kubectl/






