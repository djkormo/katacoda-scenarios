Backup cluster k8s

Backup etcd to file /opt/etcd-backup.db


`kubectl get pods -n kube-system`{{execute}}


`kubectl get pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe  pods -n kube-system -l component=etcd |grep Command: -A18`{{execute}}

`etcdctl`{{execute}}
<pre>
Command 'etcdctl' not found, but can be installed with:

snap install etcd         # version 3.4.5, or
apt  install etcd-client

See 'snap info etcd' for additional versions.
</pre>

`apt-get install etcd-client -y`{{execute}}

`etcdctl --version`{{execute}}

<pre>
etcdctl version: 3.2.17
API version: 2
</pre>

`export ETCDCTL_API=3 
etcdctl version`{{execute}}
<pre>
etcdctl version: 3.2.17
API version: 3.2
</pre>

`etcdctl snapshot save help`{{execute}}


To continue you have to backup etcd to /opt/etcd-backup.db file









