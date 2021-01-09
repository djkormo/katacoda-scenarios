

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






