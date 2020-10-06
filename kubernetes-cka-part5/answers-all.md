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

cp  pod-webapp.yaml pod-webapp-volume.yaml

change pod name and add volume

kubectl apply -f pod-webapp-volume.yaml -n vol


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

**3. Configure a volume to store pod webapp logs at /var/log/webapp on the host**
<pre>
Pod name: webapp-volume-host
Volume Name: webapp-host
Image Name: nginx:latest
Volume HostPath: /var/log/nginx/
Volume Mount: /var/log/nginx/
</pre>


cp  pod-webapp-volume.yaml pod-webapp-volume-host.yaml

change pod name and change volume

kubectl apply -f pod-webapp-volume-host.yaml -n vol


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



**4. Create a 'Persistent Volume' with the given specification.**
<pre>
    Volume Name: pv-data
    Storage: 50Mi
    Access modes: ReadWriteMany
    Host Path: /var/log/data 
</pre>

vim pv-data.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-data
spec:
  capacity:
    storage: 50Mi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /var/log/data
``` 

kubectl apply -f pv-data.yaml


**5.Create a 'Persistent Volume Claim' with the given specification.***

<pre>
    Volume Name: pvc-log
    Storage: 30Mi
    Access modes: ReadWriteOnce
    Host Path: /var/log/data 
</pre>

vim pvc-log.yaml


```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-log
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 30Mi
```     

kubectl apply -f pvc-log.yaml -n vol


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


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp
  namespace: vol
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
```


```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-volume
  labels:
    type: local
spec:
  storageClassName: local-storage
  capacity:
    storage: 50Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-volume
  namespace: vol
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 30Mi
  storageClassName: local-storage
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-volume
  namespace: vol
spec:
  volumes:
    - name: pvc-storage
      persistentVolumeClaim:
        claimName: pvc-volume
  containers:
    - name: nginx-volume
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: pvc-storage
```


cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: webapp
  namespace: vol
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
---        
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-volume
spec:
  storageClassName: local-storage
  capacity:
    storage: 50Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"      
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-volume
  namespace: vol
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 30Mi
  storageClassName: local-storage
---  
apiVersion: v1
kind: Pod
metadata:
  name: webapp-volume
  namespace: vol
spec:
  volumes:
    - name: pvc-storage
      persistentVolumeClaim:
        claimName: pvc-volume
  containers:
    - name: nginx-volume
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: pvc-storage           
EOF
