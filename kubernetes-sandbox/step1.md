

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

Sample application is installed


`kubectl get all,ep`{{execute}}

https://kubernetes.io/docs/tutorials/stateless-application/guestbook/


Expose app

`kubectl expose deploy/frontend -n default --name=external-in-katacoda  --external-ip=[[HOST_IP]] --port=8080 --target-port=8080`{{execute}}


https://learnk8s.io/blog/kubectl-productivity

Have fun !

Optionally you can configure bash completion

`apt-get install bash-completion`{{execute}}

`source /usr/share/bash-completion/bash_completion`{{execute}}

`echo 'source <(kubectl completion bash)' >>~/.bashrc`{{execute}}

`echo 'alias k=kubectl' >>~/.bashrc`{{execute}}

`echo 'complete -F __start_kubectl k' >>~/.bashrc`{{execute}}

Reload shell

`source ~/.bashrc`{{execute}}

https://kubernetes.io/docs/tasks/tools/install-kubectl/






