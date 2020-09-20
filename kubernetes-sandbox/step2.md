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

If etcdctl is not found we have to install it.

`apt-get install etcd-client -y`{{execute}}

Only 3.x version and 3.x API version should be used.

`etcdctl --version`{{execute}}

<pre>
etcdctl version: 3.2.17
API version: 2
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
  snapshot save filename
  `{{copy}}


* Remember the objects in default namespace
`kubectl get all -n default`{{execute}}
<pre>

NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-6b474476c4-68shl   1/1     Running   0          7m2s
pod/my-nginx-6b474476c4-khvs9   1/1     Running   0          7m2s
pod/my-nginx-6b474476c4-r8x6n   1/1     Running   0          7m2s

NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes     ClusterIP      10.96.0.1      <none>        443/TCP        12m
service/my-nginx-svc   LoadBalancer   10.101.83.14   <pending>     80:31662/TCP   12m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-nginx   3/3     3            3           12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-6b474476c4   3         3         3       12m
controlplane $ kubectl get all,ep -n default
NAME                            READY   STATUS    RESTARTS   AGE
pod/my-nginx-6b474476c4-68shl   1/1     Running   0          7m20s
pod/my-nginx-6b474476c4-khvs9   1/1     Running   0          7m20s
pod/my-nginx-6b474476c4-r8x6n   1/1     Running   0          7m20s

NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes     ClusterIP      10.96.0.1      <none>        443/TCP        12m
service/my-nginx-svc   LoadBalancer   10.101.83.14   <pending>     80:31662/TCP   12m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-nginx   3/3     3            3           12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/my-nginx-6b474476c4   3         3         3       12m

NAME                     ENDPOINTS                             AGE
endpoints/kubernetes     172.17.0.65:6443                      12m
endpoints/my-nginx-svc   10.5.1.6:80,10.5.1.7:80,10.5.1.8:80   12m
</pre>



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


Literature:

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster






