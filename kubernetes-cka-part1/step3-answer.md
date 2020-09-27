To continue you have to restore etcd from /opt/etcd-backup.db file.

An example:

<pre>
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --data-dir=/var/lib/etcd-backup \
  --initial-cluster-token=etcd-cluster-1 \
  snapshot restore /opt/etcd-backup.db
</pre>

Make corrections in static etcd pod
/etc/kubernetes/manifests/etcd.yaml

Change data-dir,initial-cluster-token and volume paths


Literature: 
https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/practice-questions-answers/cluster-maintenance/backup-etcd/etcd-backup-and-restore.md