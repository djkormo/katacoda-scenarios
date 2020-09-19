Install cluster with kubeadm 


`kubeadm version -o short`{{execute}}


If you need a cluster available,

The Kubernetes nodes are not configured. If you want to configure the nodes then you'd need to run kubeadm which has been set and configured. For example, for following command will initialise the master with the latest version installed.

`kubeadm init --kubernetes-version $(kubeadm version -o short) --pod-network-cidr 10.5.0.0/16`{{execute HOST1}}



`mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config`{{execute}}

Initialize cluster networking:

`kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml`{{execute}}


 (Optional) Create an nginx deployment:

 `kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml`{{execute}}



On worker node (node01) execute  kubeadm join 

`kubectl cluster-info`{{execute}}

`kubectl get nodes`{{execute}}

`kubectl get pod -o wide`{{execute}}

