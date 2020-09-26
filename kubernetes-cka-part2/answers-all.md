STEP 1

1. run

kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client > web-pod.yaml


2. use

edit vim web-pod.yaml

add port 443

save 

3. deploy

kubectl apply -f web-pod.yaml -n alpha

kubectl expose pod/web --name=webservice -n alpha


STEP 2

1. 

kubectl run postgresql --image=postgres:12.4 --port 5432  \
-o yaml --dry-run=client > postgresql-pod.yaml

kubectl apply -f postgresql-pod.yaml -n alpha


2. 

kubectl run postgresql-env --image=postgres:12.4 --port 5432  \
  --env="POSTGRES_DB=postgresdb" --env="POSTGRES_USER=postgresadmin" --env=POSTGRES_PASSWORD=admin123 \
  -o yaml --dry-run=client  > postgresql-env-pod.yaml

kubectl apply -f postgresql-env-pod.yaml -n alpha

3. 

kubectl create configmap postgresql-configmap   --from-literal="POSTGRES_DB=postgresdb"  \
  --from-literal="POSTGRES_USER=postgresadmin" \
  --from-literal="POSTGRES_PASSWORD=admin123" \
  -n alpha -o yaml --dry-run=client > postgresql-configmap.yaml

kubectl apply -f postgresql-configmap.yaml -n alpha


4. 


cp postgresql-pod.yaml postgresql-cm-pod.yaml

vim postgresql-cm-pod.yaml

change name to postgresql-cm
add  
```yaml
envFrom:
  - configMapRef:
    name: postgresql-configmap
```
Based on 
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/

kubectl apply -f postgresql-cm-pod.yaml -n alpha

5. 

kubectl create configmap postgresql-configmap-nopass \
  --from-literal="POSTGRES_DB=postgresdb" \
  --from-literal=POSTGRES_USER=postgresadmin \
  -o yaml --dry-run=client > postgresql-configmap-nopass.yaml

kubectl apply -f postgresql-configmap-nopass.yaml -n alpha


6.

kubectl create secret generic postgresql-secret \
--from-literal="POSTGRES_PASSWORD=admin123"  \
-o yaml  --dry-run=client  > postgresql-secret.yaml


kubectl apply -f postgresql-secret.yaml -n alpha

7.

cp  postgresql-cm-pod.yaml postgresql-cm-secret.yaml

vim postgresql-cm-secret.yaml

change name to postgresql-cm-secret
change configmap name
add secret reference

```yaml
envFrom:
- configMapRef:
    name: postgresql-configmap-nopass
- secretRef:
    name: postgresql-secret
```

kubectl apply -f  postgresql-cm-secret.yaml  -n alpha

8. 

kubectl expose pod/postgresql-cm-secret --name=postgresql-webservice -n alpha

Based on 
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/


Bonus

kubectl exec -it  postgresql-cm-secret -n alpha -- bash
Inside the pod

psql -U postgresadmin -d postgresdb

select * from pg_tables;

\quit