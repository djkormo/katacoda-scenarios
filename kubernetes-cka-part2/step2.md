Extending pods configuration

In aplha namespace

**1.Create a pod named postgresql using image postgresql:12.4, on port 5432.**


**2.Create a pod named postgresql-env using image postgresql:12.4, on port 5432.**

and add to pod environment variables

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123

**3.Create a configmap named postgresql-configmap with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123

**4.Create a pod named postgresql-cm using image postgresql:12.4, on port 5432.**

instead of environment variables use
config map postgresql-configmap


**5.Create a configmap named postgresql-configmap-nopass with following content**

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin

**6.Create a secret named postgresql-secret with following content**

POSTGRES_PASSWORD: admin123


**7.Create a pod named postgresql-cm-secret using image postgresql:12.4, on port 5432.**

use 
configmap postgresql-configmap-nopass
and
secret postgresql-secret


**8.Create a service as ClusterIP to expose pod postgresql-cm-secret, named as posgresql-webservice**


`kubectl get pod,svc,ep -n alpha`{{execute}}

















