## STEP 1

```bash
kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client > 01-web-pod.yaml
```
edit

```
vim 01-web-pod.yaml
```

add port 443

```bash
kubectl apply -f 01-web-pod.yaml -n alpha

kubectl expose pod/web --name=webservice -n alpha -o yaml --dry-run=client > 01-webservice-service.yaml
```


The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: web
  name: web
  namespace: alpha 
spec:
  containers:
  - image: nginx:1.11.9-alpine
    name: web
    ports:
    - containerPort: 80
    - containerPort: 443
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: web
  name: webservice
  namespace: alpha
spec:
  ports:
  - name: port-1
    port: 80
    protocol: TCP
    targetPort: 80
  - name: port-2
    port: 443
    protocol: TCP
    targetPort: 443
  selector:
    run: web
status:
  loadBalancer: {}
EOF
```


## STEP 2

**1.Create a pod named postgresql using image postgres:12.4 on port 5432**
```bash
kubectl run postgresql --image=postgres:12.4 --port 5432  \
  -o yaml --dry-run=client > 02-postgresql-pod.yaml

kubectl apply -f 02-postgresql-pod.yaml -n alpha
```

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: postgresql
  name: postgresql
  namespace: alpha
spec:
  containers:
  - image: postgres:12.4
    name: postgresql
    ports:
    - containerPort: 5432
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
EOF
```


**2.Create a pod named postgresql-env using image postgres:12.4 on port 5432.**

add to pod environment variables

POSTGRES_DB: postgresdb
POSTGRES_USER: postgresadmin
POSTGRES_PASSWORD: admin123

```bash
kubectl run postgresql-env --image=postgres:12.4 --port 5432  \
  --env="POSTGRES_DB=postgresdb" --env="POSTGRES_USER=postgresadmin" --env="POSTGRES_PASSWORD=admin123" \
  -o yaml --dry-run=client  > 02-postgresql-env-pod.yaml

kubectl apply -f 02-postgresql-env-pod.yaml -n alpha
```

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: postgresql-env
  name: postgresql-env
  namespace: alpha
spec:
  containers:
  - env:
    - name: POSTGRES_DB
      value: postgresdb
    - name: POSTGRES_USER
      value: postgresadmin
    - name: POSTGRES_PASSWORD
      value: admin123
    image: postgres:12.4
    name: postgresql-env
    ports:
    - containerPort: 5432
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
EOF
```


**3.Create a configmap named postgresql-configmap with following content**

```bash
kubectl create configmap postgresql-configmap   --from-literal="POSTGRES_DB=postgresdb"  \
  --from-literal="POSTGRES_USER=postgresadmin" \
  --from-literal="POSTGRES_PASSWORD=admin123" \
  -n alpha -o yaml --dry-run=client > 02-postgresql-configmap.yaml

kubectl apply -f 02-postgresql-configmap.yaml -n alpha
```


```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  POSTGRES_DB: postgresdb
  POSTGRES_PASSWORD: admin123
  POSTGRES_USER: postgresadmin
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: postgresql-configmap
  namespace: alpha
EOF
```

**4.Create a pod named postgresql-cm using image postgres:12.4 on port 5432.**

```bash
cp 02-postgresql-env-pod.yaml 02-postgresql-cm-pod.yaml

vim 02-postgresql-cm-pod.yaml
```

change name to postgresql-cm
add  

```yaml
envFrom:
  - configMapRef:
    name: postgresql-configmap
```

```bash
kubectl apply -f postgresql-cm-pod.yaml -n alpha
```

The whole file

```yaml
cat <<EOF | kubectl apply -f -
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
EOF  
```


Based on 
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/


**5.Create a configmap named postgresql-configmap-nopass with following content**

```bash
kubectl create configmap postgresql-configmap-nopass \
  --from-literal="POSTGRES_DB=postgresdb" \
  --from-literal=POSTGRES_USER=postgresadmin \
  -o yaml --dry-run=client > 02-postgresql-configmap-nopass.yaml

kubectl apply -f 02-postgresql-configmap-nopass.yaml -n alpha
```

or  

```bash
cp 02-postgresql-configmap.yaml 02-postgresql-configmap-nopass.yaml
vim 02-postgresql-configmap-nopass.yaml
```
change name to postgresql-configmap-nopass
and remove POSTGRES_PASSWORD
```
kubectl apply -f 02-postgresql-configmap-nopass.yaml -n alpha
```


```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  POSTGRES_DB: postgresdb
  POSTGRES_USER: postgresadmin
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: postgresql-configmap-nopass
  namespace: alpha
EOF
```

**6.Create a secret named postgresql-secret with following content**

```bash
kubectl create secret generic postgresql-secret \
--from-literal="POSTGRES_PASSWORD=admin123"  \
-o yaml  --dry-run=client  > 02-postgresql-secret.yaml

kubectl apply -f 02-postgresql-secret.yaml -n alpha
```

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  POSTGRES_PASSWORD: YWRtaW4xMjM=
kind: Secret
metadata:
  creationTimestamp: null
  name: postgresql-secret
  namespace: alpha
EOF
```

**7.Create a pod named postgresql-cm-secret using image postgres:12.4, on port 5432.**

```bash
cp  02-postgresql-cm-pod.yaml 02-postgresql-cm-secret.yaml

vim 02-postgresql-cm-secret.yaml
```

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


```bash
kubectl apply -f  02-postgresql-cm-secret.yaml  -n alpha
```

The whole file

```yaml
cat <<EOF | kubectl apply -f -
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
EOF  
```


**8.Create a service as ClusterIP to expose pod postgresql-cm-secret, named as postgresql-webservice**

```bash
kubectl expose pod/postgresql-cm-secret --name=postgresql-webservice -n alpha -o yaml --dry-run=client > 02-postgresql-webservice.yaml

kubectl apply -f 02-postgresql-webservice.yaml -n alpha

```

The whole file

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: postgresql-cm-secret
  name: postgresql-webservice
  namespace: alpha 
spec:
  ports:
  - port: 5432
    protocol: TCP
    targetPort: 5432
  selector:
    run: postgresql-cm-secret
status:
  loadBalancer: {}
EOF  
```


Based on 
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/


### Bonus 

**Not required to access the next part**

```bash
kubectl exec -it  postgresql-cm-secret -n alpha -- bash
```

Inside the pod run

```bash
psql -U postgresadmin -d postgresdb

select * from pg_tables;

\quit
```

## STEP 3


**1.Create a deploy named nginx-deployment using image nginx:1.18.0 on port 80.**

```bash
kubectl create deployment nginx-deployment --image=nginx:1.18.0 -n alpha \
-o yaml --dry-run=client > 03-nginx-deployment-alpha.yaml
```

remember to add  80 containerPort

```bash 
vim 03-nginx-deployment-alpha.yaml
```

```bash
kubectl apply -f 03-nginx-deployment-alpha.yaml -n alpha --record
```

the whole file

```yaml
cat <<EOF | kubectl apply -f -
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
EOF        
```





**2.Expose deployment nginx-deployment named nginx-service using ClusterIP.**

```bash
kubectl expose deploy nginx-deployment -n alpha -o yaml --port 80 --name=nginx-service \
--dry-run=client  > 03-nginx-service-alpha.yaml

kubectl apply -f 03-nginx-service-alpha.yaml -n alpha
```

the whole file

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment
  name: nginx-service
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-deployment
status:
  loadBalancer: {}
EOF  
```
**3.Change image in nginx-deployment to nginx:1.19.2 Record the change**

```bash
kubectl set image deploy nginx-deployment -n alpha nginx=nginx:1.19.2 \
  -o yaml --dry-run=client > 03-nginx-deployment2-alpha.yaml

kubectl apply -f 03-nginx-deployment2-alpha.yaml -n alpha --record

kubectl rollout history deploy/nginx-deployment -n alpha
```


**4.Rollback nginx-deployment to previous version**

```bash 
kubectl rollout undo deployment nginx-deployment -n alpha
kubectl rollout history deploy/nginx-deployment -n alpha
```

**5.Scale deployment nginx-deployment to 5 replicas**
```bash
kubectl scale deploy nginx-deployment -n alpha --replicas=5
```


**6. Use busybox image to get access to nginx webpage. Store the content to /var/answers/nginx.html**

```bash
kubectl run busybox -it --rm --image=busybox -- sh
```


## STEP 4

**1.Create a pod named nginx-pod-limit using image nginx:1.18.0 on port 80 add 200m CPU limit and 700Mi memory limit**

```bash
kubectl run nginx-pod-limit -n alpha --image=nginx:1.18.0 --limits="memory=700Mi,cpu=200m" --port=80  -o yaml --dry-run=client >04-pod-nginx-limit.yaml

kubectl apply -f 04-pod-nginx-limit.yaml -n alpha
```

**2.Create a pod named nginx-pod-request using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request**

```
kubectl run nginx-pod-request -n alpha --image=nginx:1.18.0 --requests="memory=500Mi,cpu=100m" --port=80  -o yaml --dry-run=client >04-pod-nginx-request.yaml

kubectl apply -f 04-pod-nginx-request.yaml -n alpha
```

**3.Create a pod named nginx-pod-request-limit using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

```
kubectl run nginx-pod-request-limit -n alpha --image=nginx:1.18.0 --port=80 \
  --requests="memory=500Mi,cpu=100m"  --limits="memory=700Mi,cpu=200m" \
  -o yaml --dry-run=client >04-pod-nginx-request-limit.yaml

kubectl apply -f 04-pod-nginx-request-limit.yaml -n alpha
```

**4.Create deployment  nginx-deployment-request-limit  using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit**

```bash
kubectl create deployment nginx-deployment-request-limit -n alpha --image=nginx:1.18.0 \
  -o yaml --dry-run=client > 04-nginx-deployment-request-limit.yaml
```
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

```
kubectl apply -f 04-nginx-deployment-request-limit.yaml -n alpha
```
The whole file

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
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
EOF            
```

**5.Expose deployment nginx-deployment-request-limit named nginx-service-request-limit using ClusterIP and port 80.**

```bash
kubectl expose deploy/nginx-deployment-request-limit --name nginx-service-request-limit --port 80 -n alpha -o yaml --dry-run=client > 04-nginx-service-request-limit.yaml

kubectl apply -f 04-nginx-service-request-limit.yaml -n alpha
```

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment-request-limit
  name: nginx-service-request-limit
  namespace: alpha
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-deployment-request-limit
status:
  loadBalancer: {}
EOF
```

## STEP 5

Placing pods on proper nodes

```kubectl describe nodes | egrep "Name:|Taints:"```{{execute}}

<pre>
Name:               controlplane
Taints:             node-role.kubernetes.io/master:NoSchedule
Name:               node01
Taints:             <none>
</pre>

```kubectl get nodes --show-labels```{{execute}}

<pre>
NAME           STATUS   ROLES    AGE     VERSION   LABELS
controlplane   Ready    master   3m24s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/master=,whereareyou=master
node01         Ready    <none>   2m51s   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux,whereareyou=worker
</pre>

All objects should by deployed into **beta** namespace.

Create **beta** namespace if needed

**1.Create a pod named nginx-pod-master-name using image nginx:1.18.0 on port 80. Deploy pod only on master node. Do not use taints and tolerations. Use node name**

```bash

kubectl run nginx-pod-master-name -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-name.yaml

```

edit

```
vim 05-nginx-pod-master-name.yaml
```
add 
nodeName: controlplane
save file

```
kubectl apply -f 05-nginx-pod-master-name.yaml
```

```
kubectl get pod nginx-pod-master-name -n beta -o wide
```
<pre>
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx-pod-master-name   1/1     Running   0          17s   10.244.0.5   controlplane   <none>           <none>

</pre>

The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx-pod-master-name
  name: nginx-pod-master-name
  namespace: beta
spec:
  containers:
  - image: nginx:1.18.0
    name: nginx-pod-master-name
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  nodeName: controlplane
status: {}
EOF
```    

CHECK

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "containerPort: 80" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name -o yaml -n beta |grep "image: nginx:1.18.0" && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep controlplane && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i taint && echo "done"`{{execute}} 

`kubectl get pod nginx-pod-master-name  -n beta -o wide | grep -v -i toleration && echo "done"`{{execute}} 

CHECK


**2.Create a pod named nginx-pod-master-selector using image nginx:1.18.0 on port 80. Deploy pod only on node01 (worker) node. Do not use taints and tolerations. Use node selector**

Check labels on nodes. 

k get nodes --show-labels
<pre>
NAME           STATUS   ROLES    AGE   VERSION   LABELS

controlplane   Ready    master   32m   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/master=,whereareyou=master

node01         Ready    <none>   32m   v1.19.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux,whereareyou=worker
</pre>

```
kubectl run nginx-pod-worker-selector -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-worker-selector.yaml
```

edit

```
vim 05-nginx-pod-worker-selector.yaml
```

add 
  nodeSelector:
    whereareyou: worker

save file

```
kubectl apply -f 05-nginx-pod-worker-selector.yaml
kubectl get pod nginx-pod-worker-selector -n beta -o wide
kubectl describe pod nginx-pod-worker-selector -n beta | grep "Node-Selectors"
```
<pre>
  ...
  Node-Selectors:  whereareyou=worker
  ...
Events:
  Type    Reason     Age   From             Message
  ----    ------     ----  ----             -------
  Normal  Scheduled  10s                    Successfully assigned alpha/nginx-pod-worker-selector to node01
  ...
</pre>

    
Whole file

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx-pod-worker-selector
  name: nginx-pod-worker-selector
  namespace: beta
spec:
  containers:
  - image: nginx:1.18.0
    name: nginx-pod-worker-selector
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  nodeSelector:
    whereareyou: worker
status: {}
EOF
```    


**3.Create a pod named nginx-pod-master-tolerations using image nginx:1.18.0 on port 80. Deploy pod only on master node. Use taints,tolerations and node selector.**



```
kubectl run nginx-pod-master-tolerations -n beta --image=nginx:1.18.0 --port=80 -o yaml --dry-run=client >05-nginx-pod-master-tolerations.yaml
```

edit

```
vim 05-nginx-pod-master-tolerations.yaml
```
add

```yaml 
  tolerations:
  - key: "node-role.kubernetes.io/master"
    effect: "NoSchedule"
  nodeSelector:
    whereareyou: master
```
save file

```
kubectl apply -f  05-nginx-pod-master-tolerations.yaml 
```

```
kubectl get pod nginx-pod-master-tolerations -n beta -o wide
kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Tolerations"
kubectl describe pod nginx-pod-master-tolerations -n beta | grep "Node-Selectors"
```

<pre>
Tolerations:     node-role.kubernetes.io/master:NoSchedule
Node-Selectors:  whereareyou=master

Events:
  Type    Reason     Age   From                   Message
  ----    ------     ----  ----                   -------
  Normal  Scheduled  3m1s                         Successfully assigned beta/nginx-pod-master-tolerations tocontrolplane
  Normal  Pulled     3m1s  kubelet, controlplane  Container image "nginx:1.18.0" already present on machine
  Normal  Created    3m    kubelet, controlplane  Created container nginx-pod-master-tolerations
  Normal  Started    3m    kubelet, controlplane  Started container nginx-pod-master-tolerations
</pre>


The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx-pod-master-tolerations
  name: nginx-pod-master-tolerations
  namespace: beta
spec:
  containers:
  - image: nginx:1.18.0
    name: nginx-pod-master-tolerations
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
  - key: "node-role.kubernetes.io/master"
    effect: "NoSchedule"
  nodeSelector:
    whereareyou: master
status: {}
EOF
```    


**4.Create a daemonset named nginx-ds using image nginx:1.18.0 on port 80 add 100m CPU request and 500Mi memory request and 200m CPU limit and 700Mi memory limit. Running on all cluster nodes.**

```
kubectl create  deployment  nginx-ds --image=nginx:1.18.0 --namespace=beta --port=80 -o yaml --dry-run=client > 05-ds-nginx-limits-resources.yaml
```

edit

```
vim 05-ds-nginx-limits-resources.yaml
```

change Deployment to DaemonSet
remove replicas, strategy and status

```
  kubectl apply -f 05-ds-nginx-limits-resources.yaml
```

```
kubectl get pod -n beta -o wide | grep nginx-ds
```
<pre>
nginx-ds-h4z7m                 1/1     Running   0          116s   10.244.1.8   node01         <none>   <none>
</pre>

Why is not running on controlplane (master) node ?

 vim 05-ds-nginx-limits-resources.yaml

 add toleration 

```yaml
  tolerations:
  - key: "node-role.kubernetes.io/master"
    effect: "NoSchedule"
```

```
kubectl get pod -n beta -o wide | grep nginx-ds
```
<pre>
nginx-ds-frwmm                 1/1     Running   0          5s    10.244.1.9   node01         <none>  <none>
nginx-ds-th7dd                 1/1     Running   0          17s   10.244.0.6   controlplane   <none>  <none>
</pre>

Remember to add resources


The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  creationTimestamp: null
  labels:
    app: nginx-ds
  name: nginx-ds
  namespace: beta
spec:
  selector:
    matchLabels:
      app: nginx-ds
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-ds
    spec:
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: 200m
            memory: 700Mi
          requests:
            cpu: 100m
            memory: 500Mi
      tolerations:
      - key: "node-role.kubernetes.io/master"
        effect: "NoSchedule"
EOF
```


**5.Create second scheduler on kubernetes cluster named my-scheduler using ports  insecure 54321  and secure 54322**

```
kubectl get pod -n kube-system -l component=kube-scheduler
```
<pre>
NAME                          READY   STATUS    RESTARTS   AGE
kube-scheduler-controlplane   1/1     Running   0          33m
</pre>

Now we have static pod (-nodename as suffix)
```
cp /etc/kubernetes/manifests/kube-scheduler.yaml /tmp/my-scheduler.yaml
```
vim /tmp/my-scheduler.yaml

change name to my-scheduler

and add like below

- --leader-elect=false
- --port=54321
- --secure-port=54322
- --scheduler-name=my-scheduler

remember to change port for liveness and readiness to secure-port number

```
cp /tmp/my-scheduler.yaml /etc/kubernetes/manifests/
```
```
kubectl describe my-scheduler-controlplane -n kube-system
kubectl logs my-scheduler-controlplane -n kube-system
```

The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-scheduler
    tier: control-plane
  name: my-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=false
    - --port=54321
    - --secure-port=54322
    - --scheduler-name=my-scheduler
    image: k8s.gcr.io/kube-scheduler:v1.19.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 54322
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-scheduler
    resources:
      requests:
        cpu: 100m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 54322
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/kubernetes/scheduler.conf
      name: kubeconfig
      readOnly: true
  hostNetwork: true
  priorityClassName: system-node-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/scheduler.conf
      type: FileOrCreate
    name: kubeconfig
status: {}
EOF
```

**6.Create a deployment named nginx-deployment-my-scheduler using image nginx:1.18.0 on port 80 and my-scheduler scheduler**

```
kubectl create  deployment  nginx-deployment-my-scheduler --image=nginx:1.18.0  --namespace=beta --port=80 -o yaml --dry-run=client > 05-deploy-nginx-my-scheduler.yaml
```
edit
```
vim 05-deploy-nginx-my-scheduler.yaml
```
add

```yaml
schedulerName: my-scheduler
```
```
kubectl apply -f  05-deploy-nginx-my-scheduler.yaml
```

The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment-my-scheduler
  name: nginx-deployment-my-scheduler
  namespace: beta
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-deployment-my-scheduler
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deployment-my-scheduler
    spec:
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
      schedulerName: my-scheduler
EOF
```



**7.Expose deployment nginx-deployment-my-scheduler named nginx-service-deployment-myscheduler using ClusterIP and port 80.**

```
kubectl expose deploy/nginx-deployment-my-scheduler -n beta --name nginx-service-deployment-my-scheduler -o yaml --dry-run=client > 05-service-deploy-nginx-my-scheduler.yaml
```
edit 
```
vim 05-service-deploy-nginx-my-scheduler.yaml
```
add 
```yaml
namespace: beta
```
save file

```bash 
kubectl apply -f 05-service-deploy-nginx-my-scheduler.yaml
```
The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment-my-scheduler
  name: nginx-service-deployment-my-scheduler
  namespace: beta
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-deployment-my-scheduler
status:
  loadBalancer: {}
EOF
```


**8.Create a deployment named nginx-deployment-all-nodes using image nginx:1.18.0 on port 80 running on all (two) nodes. Regadless replicas above number od nodes. Use affinity**

Set number of replicas = 5

```
kubectl create  deployment  nginx-deployment-all-nodes --image=nginx:1.18.0  --namespace=beta --port=80 -o yaml --dry-run=client > 05-deploy-nginx-all-nodes.yaml
```
edit
```
vim 05-deploy-nginx-all-nodes.yaml
```
add

```yaml
schedulerName: my-scheduler
```
```
kubectl apply -f  05-deploy-nginx-all-nodes.yaml
```

The complete yaml manifest

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-deployment-all-nodes
  name: nginx-deployment-all-nodes
  namespace: beta
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx-deployment-all-nodes
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deployment-all-nodes
    spec:
      containers:
      - image: nginx:1.18.0
        name: nginx
        ports:
        - containerPort: 80
        resources: {}
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - nginx-deployment-all-nodes
            topologyKey: "kubernetes.io/hostname"
      tolerations:
      - key: "node-role.kubernetes.io/master"
        effect: "NoSchedule"
status: {}
EOF
```

