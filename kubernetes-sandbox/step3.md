Restore cluster k8s

Restore etcd from file /opt/etcd-backup.db


`kubectl get pods -n kube-system`{{execute}}

`kubectl get pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe  pods -n kube-system -l component=etcd |grep Command: -A18`{{execute}}


</pre>

To use API 3.x set ETCDCTL_API variable

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
  snapshot restore filename
  `{{copy}}

Checking status of restore


To continue you have to restore etcd from /opt/etcd-backup.db file



Literature:

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster







