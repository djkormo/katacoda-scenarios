

**When all nodes are ready and version v1.19.0** 

<pre>
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   3m   v1.19.0
node01   Ready    <none>   3m   v1.19.0
</pre>

click ```clear```{{execute interrupt}} to begin

Lets try to control remainning time to reset our sandbow

<pre>
58 min root@master
</pre>

It means that you have only 58 minutes to finish the lab!!

Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.19 version

Show all namespaces

`kubectl get ns`{{execute}}

List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}

Create namespace alpha 

`kubectl create ns alpha`{{copy}}

and 

**1.Create a pod named web using image nginx:1.11.9-alpine, on port 80 and 443.** 

`kubectl get pod -n alpha`{{execute}}
<pre>

NAME   READY   STATUS    RESTARTS   AGE
web    1/1     Running   0          49s

</pre>

CHECK
`kubectl get pod web -n alpha |grep Running  && echo "done"`{{execute}}
`kubectl get pod web -n alpha -o yaml  |grep 'image: nginx:1.11.9-alpine' && echo "done"`{{execute}}
CHECK


**2.Create a service to expose that pod, named as webservice**

`kubectl get pod,svc,ep -n alpha`{{execute}}

<pre>

NAME      READY   STATUS    RESTARTS   AGE
pod/web   1/1     Running   0          51s

NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/webservice   ClusterIP   10.103.154.206   <none>        80/TCP,443/TCP   15s

NAME            ENDPOINTS                      AGE
endpoints/webservice   10.244.1.4:80,10.244.1.4:443   15s

</pre>

CHECK
`kubectl get svc webservice -n alpha |grep 80 && kubectl get svc webservice -n alpha |grep 443 &&  echo "done" `{{execute}}
CHECK

**To move to the next step make sure to have all checks with "done"**


