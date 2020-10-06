STEP 1


**1. Create webapp pod based on image nginx:latest and port 80**

kubectl run webapp -n nginx --image=nginx:latest --port=80  -n vol -o yaml --dry-run=client > pod-webapp.yaml

kubectl apply -f pod-webapp.yaml -n vol


**2.Add to webapp pod volume named nginx-volume using emptyDir and mounted at /opt/data**

<pre>
Pod name:  webapp-volume
Volume Name: nginx-volume
Image Name: nginx:latest
Container port: 80
Volume HostPath: emptyDir()
Volume Mount: /opt/data/
</pre>


**3. Configure a volume to store pod webapp logs at /var/log/webapp on the host**
<pre>
Pod name: webapp-volume-host
Volume Name: webapp-host
Image Name: nginx:latest
Volume HostPath: /var/log/nginx/
Volume Mount: /var/log/nginx/
</pre>


```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: webapp-volume-host
  name: webapp-volume-host
  namespace: vol
spec:
  containers:
  - image: nginx:latest
    name: webapp-volume-host
    ports:
    - containerPort: 80
    resources: {}
    volumeMounts:
    - name: webapp-host
      mountPath: /var/log/nginx/
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
  - name: webapp-host
    hostPath:
      path: /var/log/nginx/
```


```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: webapp-volume
  name: webapp-volume
  namespace: vol
spec:
  containers:
  - image: nginx:latest
    name: webapp-volume
    ports:
    - containerPort: 80
    resources: {}
    volumeMounts:
    - name: nginx-volume
      mountPath: /opt/data
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
  - name: nginx-volume
    emptyDir: {}
```

controlplane $ cat pv.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-log
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /pv/log
``` 

controlplane $ cat pvc.yaml
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: claim-log-1
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Mi
```      
controlplane $ kubectl get pod
<pre>
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          6s
controlplane $ kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Bound    default/claim-log-1                           94s
</pre>

<pre>
controlplane $ kubectl get pvc
NAME          STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
claim-log-1   Bound    pv-log   100Mi      RWX                           22s
<pre>
