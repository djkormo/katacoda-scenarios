Extending pods configuration

All objects should by deployed into alpha namespace

**1.Create a pod named postgresql using image postgres:12.4 on port 5432.**

Something bad is going on

`kubectl get pod postgresql -n alpha`{{execute}}

`kubectl logs postgresql -n alpha`{{execute}}

<pre>
Error: Database is uninitialized and superuser password is not specified.
       You must specify POSTGRES_PASSWORD to a non-empty value for the
       superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

       You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
       connections without a password. This is *not* recommended.

       See PostgreSQL documentation about "trust":
       https://www.postgresql.org/docs/current/auth-trust.html

</pre>


CHECK
`kubectl get pod postgresql -n alpha && echo "done"`{{execute}}

`kubectl get pod postgresql -n alpha -o yaml |grep " containerPort: 5432" && echo "done"`{{execute}}

`kubectl get pod postgresql -n alpha -o yaml  |grep 'image: postgres:12.4' && echo "done"`{{execute}}

CHECK

Now we have to set database configuration values


**2.Create a pod named postgresql-env using image postgres:12.4 on port 5432.**

add to pod environment variables

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123

`kubectl get pod postgresql-env -n alpha`{{execute}}

`kubectl logs postgresql-env -n alpha`{{execute}}

<pre>
...
2020-09-24 22:10:12.464 UTC [1] LOG:  database system is ready to accept connections
...
</pre>


CHECK

`kubectl get pod postgresql-env -n alpha |grep Running && echo "done"`{{execute}}

`kubectl get pod postgresql-env -n alpha -o yaml |grep "containerPort: 5432"&& echo "done"`{{execute}}

`kubectl get pod postgresql-env -n alpha -o yaml  |grep 'image: postgres:12.4'&& echo "done"`{{execute}}

CHECK


**3.Create a configmap named postgresql-configmap with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123


CHECK
`kubectl get cm postgresql-configmap -n alpha && echo "done"`{{execute}}

`kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_DB: postgresdb" && echo "done"`{{execute}}

`kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_USER: postgresadmin" && echo "done"`{{execute}}

`kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_PASSWORD: admin123" && echo "done"`{{execute}}

CHECK



**4.Create a pod named postgresql-cm using image postgres:12.4 on port 5432.**

But instead of environment variables use configmap postgresql-configmap


Hint!
use:

`kubectl explain pod.spec.containers.envFrom`{{execute}}

CHECK

`kubectl get pod postgresql-cm -n alpha | grep Running && echo "done"`{{execute}}

`kubectl get pod postgresql-cm -n alpha -o yaml |grep configMapRef -A1 | grep postgresql-cm && echo "done"`{{execute}}

CHECK

**5.Create a configmap named postgresql-configmap-nopass with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin


CHECK

`kubectl get cm postgresql-configmap-nopass -n alpha && echo "done"`{{execute}}

`kubectl get cm postgresql-configmap-nopass -n alpha -o yaml | grep "POSTGRES_DB: postgresdb" && echo "done"`{{execute}}

`kubectl get cm postgresql-configmap-nopass -n alpha -o yaml | grep "POSTGRES_USER: postgresadmin" && echo "done"`{{execute}}

CHECK


**6.Create a secret named postgresql-secret with following content**

POSTGRES_PASSWORD: admin123

CHECK

`kubectl get secret postgresql-secret -n alpha && echo "done"`{{execute}}

`kubectl get secret postgresql-secret -n alpha -o yaml | grep POSTGRES_PASSWORD: && echo "done"`{{execute}}

CHECK

**7.Create a pod named postgresql-cm-secret using image postgres:12.4, on port 5432.**

use 
configmap postgresql-configmap-nopass
and
secret postgresql-secret

CHECK

`kubectl get pod postgresql-cm-secret -n alpha | grep Running && echo "done"`{{execute}}

`kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep configMapRef -A1 | grep postgresql-configmap-nopass && echo "done"`{{execute}}

`kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep secretRef: -A1| grep postgresql-secret && echo "done"`{{execute}}

CHECK


**8.Create a service as ClusterIP to expose pod postgresql-cm-secret, named as postgresql-webservice**

CHECK

`kubectl get svc postgresql-webservice -n alpha |grep 5432 && echo "done" `{{execute}}

CHECK

`kubectl get pod,cm,secret,svc,ep -n alpha`{{execute}}
<pre>

NAME                       READY   STATUS             RESTARTS   AGE
pod/postgresql             0/1     CrashLoopBackOff   8          17m
pod/postgresql-cm          1/1     Running            0          5m6s
pod/postgresql-cm-secret   1/1     Running            0          67s
pod/postgresql-env         1/1     Running            0          13m
pod/web                    1/1     Running            0          27m

NAME                                    DATA   AGE
configmap/postgresql-configmap          3      11m
configmap/postgresql-configmap-nopass   2      4m24s

NAME                         TYPE                                  DATA   AGE
secret/default-token-hbtjl   kubernetes.io/service-account-token   3      29m
secret/postgresql-secret     Opaque                                1      3m46s

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/postgresql-webservice   ClusterIP   10.103.18.155   <none>        5432/TCP         4s
service/webservice             ClusterIP   10.110.75.85    <none>        80/TCP,443/TCP   22m

NAME                             ENDPOINTS                                          AGE
endpoints/postgresql-webservice   10.244.1.10:5432,10.244.1.6:5432,10.244.1.8:5432   4s
endpoints/webservice             10.244.1.3:80,10.244.1.3:443                       22m
</pre>


**To move to the next step make sure to have all checks with "done"**

