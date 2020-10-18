
Create user john and grant him permission get, list, watch, create, update, patch, delete
for resources deployments, replicasets and pods in office namespace

Name the role : developer
Name the role binding: developer-binding-john

<pre>
namespace: office
user: john
group: developer
role: developer
binding: developer-binding-john
csr: john
</pre>

In case of

Can't load /root/.rnd into RNG
140042739192256:error:2406F079:random number generator:RAND_load_file:Cannot open file:../crypto/rand/randfile.c:88:Filename=/root/.rnd

run

`cd ~/; openssl rand -writerand .rnd`{{execute}}


If missing create the office namespace

`kubectl create namespace office`{{execute}}

create pod named nginx with image nginx in office namespace as user john


CHECK
`kubectl get csr john | grep Approved && echo "done"` {{execute}}

`kubectl get role developer -n office -o yaml | grep " deployments"  -A 7 | grep update && echo "done"`{{execute}}
`kubectl get role developer -n office -o yaml | grep " pods"  -A 7 | grep update && echo "done"`
`kubectl get role developer -n office -o yaml | grep " replicasets"  -A 7 | grep update && echo "done"`{{execute}}


`kubectl get rolebinding developer-binding-john -n office -o yaml | grep "kind: User" -A2 | grep "name: john" && echo "done"`{{execute}}

`kubectl get rolebinding developer-binding-john -n office -o yaml | grep "kind: Role" -A2 | grep "name: developer" && echo "done"`{{execute}}

`kubectl get  pods -n office | grep nginx | wc -l | grep 1 && echo "done"`{{execute}}

CHECK

**To move to the next step make sure to have all checks with "done"**


Literature:

https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster







