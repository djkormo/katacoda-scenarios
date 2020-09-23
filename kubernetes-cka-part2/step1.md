Pod and services exercises


Show list of cluster nodes

`kubectl get nodes`{{execute HOST1}}

Here we have cluster with 1.18 version

Show all namespaces

`kubectl get ns`{{execute}}


List all of objects in default namespace

`kubectl get all -o wide`{{execute HOST1}}

Create namespace alpha and ....

1. Create a pod named web using image nginx:1.11.9-alpine, on port 80 and 443. 

CHECK
`kubectl get pod web -n alpha |grep Running  && echo "done"`{{execute}}
`kubectl get pod web -n alpha -o yaml  |grep 'image: nginx:1.11.9-alpine' && echo "done"`{{execute}}
CHECK

<pre>

NAME   READY   STATUS    RESTARTS   AGE
web    1/1     Running   0          49s

</pre>

CHECK
`echo done`{{execute}}
CHECK

2. Create a service to expose that pod, named as webservice

`kubectl get pod,svc,ep -n alpha`{{execute}}

<pre>

NAME      READY   STATUS    RESTARTS   AGE
pod/web   1/1     Running   0          51s

NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/web   ClusterIP   10.103.154.206   <none>        80/TCP,443/TCP   15s

NAME            ENDPOINTS                      AGE
endpoints/web   10.244.1.4:80,10.244.1.4:443   15s

</pre>

CHECK
`echo done`{{execute}}
CHECK


3. List all the pods in alpha namespace sorted by name

CHECK
`echo "done"`{{execute}}
CHECK