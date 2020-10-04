STEP 1


kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client > web-pod.yaml

edit vim web-pod.yaml

add port 443

kubectl apply -f web-pod.yaml -n alpha

kubectl expose pod/web --name=webservice -n alpha

STEP 2

1. 

kubectl run postgresql --image=postgres:12.4 --port 5432  \
-o yaml --dry-run=client > postgresql-pod.yaml

kubectl apply -f postgresql-pod.yaml -n alpha


**2.Create a pod named postgresql-env using image postgres:12.4 on port 5432.**


kubectl run postgresql-env --image=postgres:12.4 --port 5432  \
  --env="POSTGRES_DB=postgresdb" --env="POSTGRES_USER=postgresadmin" --env=POSTGRES_PASSWORD=admin123 \
  -o yaml --dry-run=client  > postgresql-env-pod.yaml

kubectl apply -f postgresql-env-pod.yaml -n alpha

**3.Create a configmap named postgresql-configmap with following content**

kubectl create configmap postgresql-configmap   --from-literal="POSTGRES_DB=postgresdb"  \
  --from-literal="POSTGRES_USER=postgresadmin" \
  --from-literal="POSTGRES_PASSWORD=admin123" \
  -n alpha -o yaml --dry-run=client > postgresql-configmap.yaml

kubectl apply -f postgresql-configmap.yaml -n alpha


**4.Create a pod named postgresql-cm using image postgres:12.4 on port 5432.**


cp postgresql-env-pod.yaml postgresql-cm-pod.yaml

vim postgresql-cm-pod.yaml

change name to postgresql-cm
add  
```yaml
envFrom:
  - configMapRef:
    name: postgresql-configmap
```
The whole file

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: postgresql-cm
  name: postgresql-cm
  namespace: alpha
spec:
  containers:
  - envFrom:
    - configMapRef:
        name: postgresql-configmap
    image: postgres:12.4
    name: postgresql-cm
    ports:
    - containerPort: 5432
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

kubectl apply -f postgresql-cm-pod.yaml -n alpha

Based on 
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/


**5.Create a configmap named postgresql-configmap-nopass with following content**

kubectl create configmap postgresql-configmap-nopass \
  --from-literal="POSTGRES_DB=postgresdb" \
  --from-literal=POSTGRES_USER=postgresadmin \
  -o yaml --dry-run=client > postgresql-configmap-nopass.yaml

kubectl apply -f postgresql-configmap-nopass.yaml -n alpha

or  

cp postgresql-configmap.yaml postgresql-configmap-nopass.yaml
vim postgresql-configmap-nopass.yaml
change name to postgresql-configmap-nopass
and remove POSTGRES_PASSWORD

kubectl apply -f postgresql-configmap-nopass.yaml -n alpha


**6.Create a secret named postgresql-secret with following content**

kubectl create secret generic postgresql-secret \
--from-literal="POSTGRES_PASSWORD=admin123"  \
-o yaml  --dry-run=client  > postgresql-secret.yaml

kubectl apply -f postgresql-secret.yaml -n alpha


**7.Create a pod named postgresql-cm-secret using image postgres:12.4, on port 5432.**

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

The whole file
```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: postgresql-cm-secret
  name: postgresql-cm-secret
  namespace: alpha
spec:
  containers:
  - envFrom:
    - configMapRef:
        name: postgresql-configmap-nopass
    - secretRef:
        name: postgresql-secret
    image: postgres:12.4
    name: postgresql-cm-secret
    ports:
    - containerPort: 5432
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

kubectl apply -f  postgresql-cm-secret.yaml  -n alpha

**8.Create a service as ClusterIP to expose pod postgresql-cm-secret, named as postgresql-webservice**

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


STEP 3 


**1.Create a deploy named nginx-deployment using image nginx:1.18.0 on port 80.**

kubectl create deployment nginx-deployment --image=nginx:1.18.0 -n alpha \
-o yaml --dry-run=client > nginx-deployment-alpha.yaml

remember to add  80  containerPort

vim nginx-deployment-alpha.yaml

the whole file
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment
  name: nginx-deployment  
  namespace: alpha
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-deployment
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deployment
    spec:
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
```

kubectl apply -f nginx-deployment-alpha.yaml -n alpha --record

**2.Expose deployment nginx-deployment named nginx-service using ClusterIP.**
kubectl expose deploy nginx-deployment -n alpha -o yaml --port 80 --name=nginx-service \
--dry-run=client  > nginx-service-alpha.yaml

kubectl apply -f nginx-service-alpha.yaml -n alpha

**3.Change image in nginx-deployment to nginx:1.19.2 Record the change**

kubectl set image deploy nginx-deployment -n alpha nginx=nginx:1.19.2 \
  -o yaml --dry-run=client > nginx-deployment2-alpha.yaml

kubectl apply -f nginx-deployment2-alpha.yaml -n alpha --record

kubectl rollout history deploy/nginx-deployment -n alpha


**4.Rollback nginx-deployment to previous version**

kubectl rollout undo deployment nginx-deployment -n alpha

kubectl rollout history deploy/nginx-deployment -n alpha

**5.Scale deployment nginx-deployment to 5 replicas**

kubectl scale deploy nginx-deployment -n alpha --replicas=5

**6. Use busybox image to get access to nginx webpage. Store the content to /var/answers/nginx.html**

kubectl run busybox -it --rm --image=busybox -- sh



STEP 4

**1.Create a pod named nginx-pod-limit using image nginx:1.18.0 on port 80 add 200m CPU limit and 700Mi memory limit**

kubectl run nginx-pod-limit -n alpha --image=nginx:1.18.0 --limits="memory=700Mi,cpu=200m" --port=80  -o yaml --dry-run=client >pod-nginx-limit.yaml

kubectl apply -f pod-nginx-limit.yaml -n alpha

**2.Create a pod named nginx-pod-request using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request**


kubectl run nginx-pod-request -n alpha --image=nginx:1.18.0 --requests="memory=500Mi,cpu=100m" --port=80  -o yaml --dry-run=client >pod-nginx-request.yaml

kubectl apply -f pod-nginx-request.yaml -n alpha

**3.Create a pod named nginx-pod-request-limit using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

kubectl run nginx-pod-request-limit -n alpha --image=nginx:1.18.0 --port=80 \
  --requests="memory=500Mi,cpu=100m"  --limits="memory=700Mi,cpu=200m" \
  -o yaml --dry-run=client >pod-nginx-request-limit.yaml

kubectl apply -f pod-nginx-request-limit.yaml -n alpha


**4.Create deployment  nginx-deployment-request-limit  using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

kubectl create deployment nginx-deployment-request-limit -n alpha --image=nginx:1.18.0 \
  -o yaml --dry-run=client > nginx-deployment-request-limit.yaml

add  missing resources
look here
kubectl get pod nginx-pod-request-limit -n alpha -o yaml | grep resources: -A6
```yaml
    resources:
      limits:
        cpu: 200m
        memory: 700Mi
      requests:
        cpu: 100m
        memory: 500Mi
```

add  missing port
look here
kubectl get pod nginx-pod-request-limit -n alpha -o yaml | grep resources: -A6
```yaml
        name: nginx
        ports:
        - containerPort: 80
```

The whole file

```yaml
apiVersion: apps/v1
kind: Deployment
  labels:
    app: nginx-deployment-request-limit
  name: nginx-deployment-request-limit
  namespace: alpha
spec:
  replicas: 1
  selector:
    matchLabels:      
    app: nginx-deployment-request-limit
  strategy: {}
  template:
    metadata:      
    creationTimestamp: null
      labels:
        app: nginx-deployment-request-limit
    spec:      
    containers:
      - image: nginx:1.18.0
        name: nginx
        ports:        
        - containerPort: 80
        resources:
          limits:
            memory: 700Mi
            cpu: 200m
          requests:
            memory: 500Mi
            cpu: 100m
```

kubectl apply -f nginx-deployment-request-limit.yaml -n alpha

**5.Expose deployment nginx-deployment-request-limit named nginx-service-request-limit using ClusterIP and port 80.**


kubectl expose deploy/nginx-deployment-request-limit --name nginx-service-request-limit --port 80 -n alpha \
  -o yaml --dry-run=client > nginx-service-request-limit.yaml

kubectl apply -f nginx-service-request-limit.yaml -n alpha

