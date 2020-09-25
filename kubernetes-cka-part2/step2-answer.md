To continue you have to 

Examples how to start:

<pre>

1. 

kubectl run postgresql --image=postgres:12.4 --port 5432  -o yaml --dry-run=client

2. 

kubectl run postgresql-env --image=postgres:12.4 --port 5432  \
  --env="POSTGRES_DB=postgresdb" --env="POSTGRES_USER=postgresadmin" --env=POSTGRES_PASSWORD=admin123 \
  -o yaml --dry-run=client


3. 

kubectl create configmap postgresql-configmap   --from-literal="POSTGRES_DB=postgresdb"  \
  --from-literal="POSTGRES_USER=postgresadmin" --from-literal="POSTGRES_PASSWORD=admin123" \
  -n alpha -o yaml --dry-run=client

4. 




5. 

kubectl create configmap postgresql-configmap-nopass --from-literal="POSTGRES_DB=postgresdb" --from-literal=POSTGRES_USER=postgresadmin -o yaml --dry-run=client

6.

kubectl create secret generic posgresql-secret --from-literal="POSTGRES_PASSWORD=admin123"  -o yaml--dry-run=client

</pre>