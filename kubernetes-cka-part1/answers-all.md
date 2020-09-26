STEP 1

STEP 2



STEP 3


ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /opt/etcd-backup.db

STEP 4

 ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --data-dir=/var/lib/etcd-backup \
  --initial-cluster-token etcd-cluster-1 \
  snapshot restore /opt/etcd-backup.db
  
Make corrections in static etcd pod /etc/kubernetes/manifests/etcd.yaml

Change data-dir,initial-cluster-token and volume paths     
