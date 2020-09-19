Upgrade cluster from version 1.18 to 1.19


`kubectl get nodes`{{execute HOST1}}

`kubectl get pod -o wide`{{execute HOST1}}


`apt-get update`{{execute HOST1}}

`apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y`{{execute HOST1}}


`kubeadm upgrade plan`{{execute HOST1}}

`kubeadm  upgrade apply v1.19.0`{{execute HOST1}}

`kubectl get nodes`{{execute HOST1}}

`kubectl drain node01`{{execute HOST1}}

`kubectl drain node01 --ignore-daemonsets`{{execute HOST1}}

`ssh node01`{{execute HOST1}}

On node01 node

`apt-get install kubelet=1.19.0-00 -y `{{execute HOST2}}

`systemctl status kubelet`{{execute HOST2}}

`systemctl restart kubelet`{{execute HOST2}}


`systemctl status kubelet`{{execute HOST2}}

`exit`{{execute HOST2}}


On master node

`kubectl uncordon node01`{{execute HOST1}}

`kubectl get nodes`{{execute HOST1}}

`kubectl get pod -o wide`{{execute HOST1}}} 



