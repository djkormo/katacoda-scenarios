Extending pods configuration

In aplha namespace

**1.Create a pod named postgresql using image postgres:12.4, on port 5432.**

Something bad is going on

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


**2.Create a pod named postgresql-env using image postgres:12.4, on port 5432.**

and add to pod environment variables

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123


`kubectl logs postgresql-env -n alpha`{{execute}}

<pre>
...
2020-09-24 22:10:12.464 UTC [1] LOG:  database system is ready to accept connections
...
</pre>

**3.Create a configmap named postgresql-configmap with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123

**4.Create a pod named postgresql-cm using image postgres:12.4, on port 5432.**

instead of environment variables use
config map postgresql-configmap


**5.Create a configmap named postgresql-configmap-nopass with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin

**6.Create a secret named postgresql-secret with following content**

POSTGRES_PASSWORD: admin123


**7.Create a pod named postgresql-cm-secret using image postgres:12.4, on port 5432.**

use 
configmap postgresql-configmap-nopass
and
secret postgresql-secret


**8.Create a service as ClusterIP to expose pod postgresql-cm-secret, named as posgresql-webservice**


`kubectl get pod,svc,ep -n alpha`{{execute}}

















