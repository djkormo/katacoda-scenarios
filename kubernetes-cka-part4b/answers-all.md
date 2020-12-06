STEP1


kubectl convert -f /manifests/nginx-deployment.yaml > /manifests/nginx-deployment-good.yaml

/manifests/nginx-deployment-good.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: app
    name: nginx-name
  name: nginxx
  namespace: alpha
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-app
      name: nginx-name
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: nginx-app
        name: nginx-name
    spec:
      containers:
      - image: httpd
        imagePullPolicy: IfNotPresent
        name: nginx-container
        ports:
        - containerPort: 8030
          name: http
          protocol: TCP
      dnsPolicy: ClusterFirst
      restartPolicy: Always
```

Or using STDIN

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app
    name: nginx-name
  name: nginxx
  namespace: alpha
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-app
      name: nginx-name
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: nginx-app
        name: nginx-name
    spec:
      containers:
      - image: httpd
        imagePullPolicy: IfNotPresent
        name: nginx-container
        ports:
        - containerPort: 8030
          name: http
          protocol: TCP
      restartPolicy: Always
EOF



/manifests/clusterip-service.yaml

```yaml
kind: Service
apiVersion: v1
metadata:
  name: clusterip-nginx-service
  namespace: alpha
spec:
  selector:
    app: nginx-app
  ports:
  - protocol: TCP
    port: 3000
    targetPort: 8080
```
pod-fix-me.yaml

Or using STDIN

cat <<EOF | kubectl apply -f -
kind: Service
apiVersion: v1
metadata:
  name: clusterip-nginx-service
  namespace: alpha
spec:
  selector:
    app: nginx-app
  ports:
  - protocol: TCP
    port: 3000
    targetPort: 8080
EOF

fix-me-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: fix-me
  name: fix-me
  namespace: alpha
spec:
  containers:
  - image: nginx
    name: fix-me
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

Or using STDIN


```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: fix-me
  name: fix-me
  namespace: alpha
spec:
  containers:
  - image: nginx
    name: fix-me
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
EOF
```

```
kubectl get all,ep -n alpha
```
<pre>
NAME                          READY   STATUS    RESTARTS   AGE
pod/fix-me                    1/1     Running   0          2m17s
pod/nginxx-59d5cfc7b4-rdvj7   1/1     Running   0          3m26s

NAME                              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/clusterip-nginx-service   ClusterIP   10.110.98.192   <none>        3000/TCP   3m34s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginxx   1/1     1            1           3m26s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/nginxx-59d5cfc7b4   1         1         1       3m26s

NAME                                ENDPOINTS         AGE
endpoints/clusterip-nginx-service   10.244.1.7:8080   3m34s
</pre>


STEP2

kubectl get all,ep -n beta
NAME                READY   STATUS                       RESTARTS   AGE
pod/configmap-pod   0/1     CreateContainerConfigError   0          17s
pod/secret-pod      0/1     ContainerCreating            0          16s


pod/configmap-pod
Warning  Failed     6s (x5 over 44s)  kubelet, node01  Error: configmap "special-config" not found

pod/secret-pod  
Warning  FailedMount  25s (x8 over 88s)  kubelet, node01  MountVolume.SetUp failed for volume "myothersecret" : secret "myothersecret" not found

```
kubectl create configmap special-config -n beta -o yaml --dry-run=client --from-literal='special.how=nothing'
```

```yaml
apiVersion: v1
data:
  special.how: nothing
kind: ConfigMap
metadata:
  name: special-config
  namespace: beta
```

or using STDIN 

```
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  special.how: nothing
kind: ConfigMap
metadata:
  name: special-config
  namespace: beta
EOF
```


```
kubectl create secret generic myothersecret --from-literal='password=secret'   -n beta -o yaml   --dry-run=client
```

```yaml
apiVersion: v1
data:
  password: c2VjcmV0
kind: Secret
metadata:
  name: myothersecret
  namespace: beta
```

or using STDIN

```
cat <<EOF | kubectl apply -f -
apiVersion: v1
data:
  password: c2VjcmV0
kind: Secret
metadata:
  name: myothersecret
  namespace: beta
EOF
```


STEP3

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-resources
  namespace: gamma
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
  namespace: gamma
spec:
  limits:
  - default:
      cpu: 1
      memory: 200m
    defaultRequest:
      cpu: 0.5
      memory: 100m
    type: Container
EOF

STEP4

