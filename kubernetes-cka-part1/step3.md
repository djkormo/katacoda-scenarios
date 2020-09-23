Restore cluster k8s

Restore etcd from file /opt/etcd-backup.db


Something happened during the night

`kubectl get all,ep -n default`{{execute}}

In default namespace there are no deployment and service objects


Let's examine etcd configuration 

`kubectl get pods -n kube-system`{{execute}}

`kubectl get pods -n kube-system -l component=etcd`{{execute}}

`kubectl describe  pods -n kube-system -l component=etcd |grep Command: -A18`{{execute}}

<pre>
    Command:
      etcd
      --advertise-client-urls=https://172.17.0.13:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --initial-advertise-peer-urls=https://172.17.0.13:2380
      --initial-cluster=controlplane=https://172.17.0.13:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.13:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://172.17.0.13:2380
      --name=controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt

</pre>

To use API 3.x set ETCDCTL_API variable

`export ETCDCTL_API=3 
etcdctl version`{{execute}}
<pre>
etcdctl version: 3.2.17
API version: 3.2
</pre>

**Change /var/lib/etcd to /var/lib/etcd-backup while restoring** 

Hint!

use command in such a way

`ETCDCTL_API=3 etcdctl \
  --endpoints=https://[127.0.0.1]:2379 \
  --cacert=...ca.crt \
  --cert=...server.crt \
  --key=...server.key \
  --data-dir=/var/lib/etcd-backup \
  --initial-cluster-token etcd-cluster-1 \
  snapshot restore filename
  `{{copy}}


`ls -la /var/lib/etcd*`{{execute}}

<pre>
/var/lib/etcd:
total 12
drwx------  3 root root 4096 Sep 20 19:08 .
drwxr-xr-x 48 root root 4096 Sep 20 19:39 ..
drwx------  4 root root 4096 Sep 20 19:08 member

/var/lib/etcd-backup:
total 12
drwx------  3 root root 4096 Sep 20 19:39 .
drwxr-xr-x 48 root root 4096 Sep 20 19:39 ..
drwx------  4 root root 4096 Sep 20 19:39 member
</pre>



Checking status of restore

`kubectl get all,ep -n default`{{execute}}

<pre>
NAME                            READY   STATUS              RESTARTS   AGE
pod/my-nginx-6b474476c4-rc6v5   0/1     ContainerCreating   0          43m
pod/my-nginx-6b474476c4-slzqb   0/1     ContainerCreating   0          43m
pod/my-nginx-6b474476c4-vbx7h   0/1     ContainerCreating   0          43m

NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes     ClusterIP      10.96.0.1       <none>        443/TCP        47m
service/my-nginx-svc   LoadBalancer   10.96.243.139   <pending>     80:30364/TCP   46m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-nginx   3/3     3            3           46m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-6b474476c4   3         3         3       46m

NAME                     ENDPOINTS                              AGE
endpoints/kubernetes     172.17.0.13:6443                       47m
endpoints/my-nginx-svc   10.5.1.10:80,10.5.1.8:80,10.5.1.9:80   46m
</pre>

To continue you have to restore etcd from /opt/etcd-backup.db file


Literature:

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster







