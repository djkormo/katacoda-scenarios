STEP 0

On master node


kubeadm init --kubernetes-version $(kubeadm version -o short) --pod-network-cidr 192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

On worker node

kubeadm join 172.17.0.14:6443 --token aaa \
    --discovery-token-ca-cert-hash sha256:bbb

On master node

kubectl apply -f https://docs.projectcalico.org/v3.11/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml


kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml


kubectl get nodes | grep 1.18.0 | grep Ready



STEP 1


On master node

apt-get update

apt-get install kubeadm=1.19.0-00 kubectl=1.19.0-00 kubelet=1.19.0-00 -y`{{execute HOST1}}


kubeadm upgrade plan

kubeadm upgrade apply v1.19.0

kubectl get pod/alone-pod -n alone -o yaml >pod-alone-alone-pod.yaml
kubectl get pod/web-server -n alone -o yaml >pod-alone-web-server.yaml
kubectl drain node01 --ignore-daemonsets --force 

On worker node

apt-get update
apt-get install kubelet=1.19.0-00 -y

systemctl restart kubelet

On master node

kubectl uncordon node01

kubectl apply -f pod-alone-alone-pod.yaml -n alone

kubectl apply -f pod-alone-web-server.yaml -n alone

What we have in alone namespace

kubectl get pod -n alone 

CHECK

kubectl get nodes | grep 1.19.0 | grep Ready

kubectl get pod alone-pod web-server -n alone | grep Running


STEP 2

apt-get install etcd-client -y


ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /opt/etcd-backup.db


ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot status -w table /opt/etcd-backup.db

STEP 3

apt-get install etcd-client -y



ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --data-dir=/var/lib/etcd-backup \
  --initial-cluster-token=etcd-cluster-1 \
  snapshot restore /opt/etcd-backup.db

  
Make corrections in static etcd pod /etc/kubernetes/manifests/etcd.yaml

Change data-dir,initial-cluster-token and volume paths     

The whole file
```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://172.17.0.14:2379
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://172.17.0.14:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd-backup
    - --initial-advertise-peer-urls=https://172.17.0.14:2380
    - --initial-cluster=master=https://172.17.0.14:2380
    - --initial-cluster-token=etcd-cluster-1
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.14:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://172.17.0.14:2380
    - --name=master
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: k8s.gcr.io/etcd:3.4.9-1
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: etcd
    resources: {}
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /health
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /var/lib/etcd-backup
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priorityClassName: system-node-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
```
