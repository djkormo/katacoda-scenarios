Upgrade cluster from version 1.18 to 1.19


`kubectl get nodes`{{execute}}

`kubectl get pod -o wide`{{execute}}


`apt-get update`{{execute}}

`apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y`{{execute}}


`kubeadm upgrade plan`{{execute}}

`kubeadm  upgrade apply v1.19.0`{{execute}}

`kubectl get nodes`{{execute}}

`kubectl drain node01`{{execute}}

`kubectl drain node01 --ignore-daemonsets`{{execute}}

`ssh node01`{{execute}}

On node01 node

`apt-get install kubelet=1.19.0-00 -y `{{execute}}

`systemctl status kubelet`{{execute}}

`systemctl restart kubelet`{{execute}}

`systemctl status kubelet`{{execute}}

`exit`{{execute}}


On master node

`kubectl uncordon node01`{{execute}}

`kubectl get pod -o wide`{{execute}} 



