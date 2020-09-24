To continue you have to 

An example:

<pre>


1. kubectl run postgresql --image=postgres:12.4 --port 5432  -o yaml --dry-run=client


2. kubectl run postgresql-env --image=postgres:12.4 --port 5432  \
  --env="POSTGRES_DB=postgresdb" --env="POSTGRES_USER=postgresadmin" --env=POSTGRES_PASSWORD=admin123 \
  -o yaml --dry-run=client



</pre>