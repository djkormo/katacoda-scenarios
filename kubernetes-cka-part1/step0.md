**Install cluster with kubeadm** 

Lets try to control remainning time to reset our sandbow

<pre>
58 min root@master
</pre>

It means that you have only 58 minutes to finish the lab!!


`kubeadm version -o short`{{execute}}


If you need a cluster available,

The Kubernetes nodes are not configured. If you want to configure the nodes then you'd need to run kubeadm which has been set and configured. For example, for following command will initialise the master with the latest version installed.

`kubeadm init --kubernetes-version $(kubeadm version -o short) --pod-network-cidr 10.5.0.0/16`{{execute HOST1}}

Move cluster config file to your home directory.

`mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config`{{execute}}

Initialize cluster networking:

`kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml`{{execute}}

 (Optional) Create an example deployment:

 `kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml`{{execute}}


`ssh node01`{{execute}}
On worker node (node01) 
execute kubeadm join .... command.

Return to master (controlplane) node

`exit`{{execute HOST2}}

Hint

How to get join command ?

`kubeadm token create --print-join-command`{{execute}}

List of all generated tokens

`kubeadm token list`{{execute}}

Let's examine our cluster

`kubectl cluster-info`{{execute}}

Number of cluster nodes

`kubectl get nodes`{{execute}}

Example objects in default namespace

`kubectl get all -o wide`{{execute}}

To continue you should have 1.18 Kubernetes cluster with two nodes (ready)
