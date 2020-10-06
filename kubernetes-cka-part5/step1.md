**Storage exercices**

Show list of cluster nodes

`kubectl get nodes`{{execute}}

Here we have cluster with 1.18 version

Show all namespaces

`kubectl get ns`{{execute}}

List all of  storage class 

`kubectl get sc`{{execute}}

List all objects in vol naemspace

`kubectl get all,ep -n vol`{{execute}}


All namespaced objects should be deployed in **vol** namespace


**1. Create webapp pod based on image nginx:latest and port 80**

kubectl run webapp -n nginx --image=nginx:latest --port=80  -n log -o yaml --dry-run=client > pod-webapp.yaml

kubectl apply -f pod-webapp.yaml -n vol


**2. Configure a volume to store pod webapp logs at /var/log/webapp on the host**

Name: webapp-host
Image Name: nginx:latest
Volume HostPath: var/log/nginx/
Volume Mount: /var/log/nginx/

cp pod-webapp.yaml pod-webapp-host.yaml


Look at
kubectl explain pod.spec.volumes
and
kubectl explain pod.spec.containers.volumeMounts



**3. Create a 'Persistent Volume' with the given specification.**

    Volume Name: pv-data
    Storage: 50Mi
    Access modes: ReadWriteMany
    Host Path: /var/log/data 




`kubectl get sc`{{execute}}

CHECK

`kubectl get pv`{{execute}}

CHECK


**4.Create a 'Persistent Volume Claim' with the given specification.***

    Volume Name: pv-log
    Storage: 30Mi
    Access modes: ReadWriteMany
    Host Path: /var/log/data 

**5. Correct PVC to Bind to PV**


**6. Update the webapp-volume pod to use the persistent volume claim as its storage.** 

    Name: webapp
    Image Name: kodekloud/event-simulator
    Volume: PersistentVolumeClaim=claim-log-1
    Volume Mount: /log 

List all of pv

`kubectl get sc,pv `{{execute}}

List all of pvc in vol namespace

`kubectl get pvc -o wide -n vol`{{execute}}



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






https://medium.com/@ihernandezjr/a-kubernetes-developer-quick-guide-to-tricky-manifests-part-2-volume-mounts-ac28a8fb9786