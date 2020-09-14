If you need a cluster available, 

The Kubernetes nodes are not configured. If you want to configure the nodes then you'd need to run `kubeadm` which has been set and configured. For example, for following command will initialise the master with the latest version installed.

`apt install apt-transport-https dirmngr -y
echo "deb https://dl.bintray.com/wind39/omnidb-deb debian main" > /etc/apt/sources.list.d/omnidb.list
apt-key adv --recv-keys 379CE192D401AB61
apt update

apt install omnidb-app   
apt install omnidb-server`{{execute HOST1}}