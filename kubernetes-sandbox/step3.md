Restore cluster k8s

Restore etcd from file /opt/etcd-backup.db


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


Hint!

use command in such a way

`ETCDCTL_API=3 etcdctl \
  --endpoints=https://[127.0.0.1]:2379 \
  --cacert=...ca.crt \
  --cert=...server.crt \
  --key=...server.key \
  snapshot save filename
  `{{copy}}

Checking status of backup

ETCDCTL_API=3 ... snapshot status-w table /opt/etcd-backup.db
<pre>
+----------+----------+------------+------------+
|   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE |
+----------+----------+------------+------------+
| 66b8edae |     2325 |       2339 |     3.9 MB |
+----------+----------+------------+------------+
</pre>
To continue you have to backup etcd to /opt/etcd-backup.db file









