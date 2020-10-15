apt-get update
apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y

systemctl restart kubelet

kubeadm upgrade apply v1.19.0 -y

systemctl restart kubelet
