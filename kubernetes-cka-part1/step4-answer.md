

An example:


openssl genrsa -out john.key 2048
openssl req -new -key john.key -out john.csr  -subj "/CN=john/O=developer"

I case of 

Can't load /root/.rnd into RNG
140042739192256:error:2406F079:random number generator:RAND_load_file:Cannot open file:../crypto/rand/randfile.c:88:Filename=/root/.rnd

run
cd ~/; openssl rand -writerand .rnd

cat john.key
cat john.csr
cat john.csr | base64 | tr -d "\n" # -> request 

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john
spec:
  groups:
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2FEQ0NBVkFDQVFBd0l6RU5NQXNHQTFVRUF3d0VhbTlvYmpFU01CQUdBMVVFQ2d3SlpHVjJaV3h2Y0dWeQpNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTB1cnQrREVuSE5wY29sMk9TaWR2CkVZRUkvUEtmbnlHVzF6dGx6M3RYZkp0NDFraG5ZRUEvVEk2NEd6cWdha3hPNnJtQm11anJqcEJHU0RjcEJ2VU0KM3kzWUFNOEhLNFNRVmVIeVpTbUxPQ2JaQUVIMzdGclRlWW4wUVVjSWE0Uzh1a0g3VHJrZlZhVms5bmlhcUQzbwp3M1ZrZFhRa0FjS3p4U3VlZmRsRDY4dHJTU0pRVWV2dkVOSWsyTzMyV0J1eEFkbm1IN2tYQTVYb0FTMDdPS0NsClRudlFQczRZNUxvbzVHWWhvSlpSODUzSXlMZXg0cmxFVmhrTHFURldaNzFBRnE0eEdaNFJJK2JmSHJqNytRZVcKSmZ4RUE1L2szVFBTalZULzR4OFN0QkQySEtnYkhmZitWUjhialR3bDJ4Ry9XN2k0RFpOUUIvUEI5UXFXQUYxbgoyd0lEQVFBQm9BQXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBQWRlUnk1T3d1ZGIyZTJveDNhWkFpdm4vNkU4CjRwdVl5VGpuTE9FdlBkaGpENFJGblB2SktXNUVuZWRpMHM5UWwxaWR5ZFlqcERvWlN4M2RCRlQwQXVwVjVXY1IKc285Y1kyY3owWDZKMXJFbm5hbVJSQVV6aHQ3MU1FV2lyYnZTcUVDWVhwcG5ZT3JyM0lBUnpySUJwdDZBbWlsMwpPaC94MlF0NDM3ZytmSGxhREFPRmd4dEdNNnIxQUQxMmRDUUFEdEZxa2NKZXdoRjhkMlM3bHpxeEVkMG9PRlFxCnZBYUUvQ01Ibmc2N2c4OHp5UnpHeWRsdHVpRG9iL3NNSnZGaW5VbU1ibkxaTWhzRDkwT0ttc2ZRaW9OQmcwZm0KMVcyU3JON20vKzU2Sk5uUVhmenM0YlJ3cW9uZ2I2RDFORFdtZXhLY2ZFdENrcThXclJiL1FySVN2QVk9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF


`kubectl get csr john`{{cxecute}}

<pre>
NAME   AGE     SIGNERNAME                            REQUESTOR          CONDITION
john   3m48s   kubernetes.io/kube-apiserver-client   kubernetes-admin   Pending
</pre>

`kubectl certificate approve john`{{execute}}

<pre>
certificatesigningrequest.certificates.k8s.io/john approved
</pre>

`kubectl get csr john`{{execute}}
<pre>
NAME   AGE     SIGNERNAME                            REQUESTOR          CONDITION
john   5m53s   kubernetes.io/kube-apiserver-client   kubernetes-admin   Approved,Issued
</pre>

`kubectl get csr/john -o yaml`{{execute}}

`kubectl get csr/john -o jsonpath='{.status.certificate}' | base64 --decode > john.crt`{{execute}}


`kubectl create role developer --verb=get --verb=list --verb=watch \
  --verb=create --verb=update --verb=patch --verb=delete \
  --resource=pods --resource=deployments --resource=replicasets \
  -n office -o yaml --dry-run=client > developer-role.yaml`{{execute}}

`kubectl apply -f developer-role.yaml`{{execute}}

`kubectl create rolebinding developer-binding-john --role=developer --user=john -n office`{{execute}}


`kubectl config set-credentials john --client-certificate=/root/john.crt  \
  --client-key=/root/john.key --embed-certs=true`{{execute}}

<pre>  
User "john" set.
</pre>

`kubectl config set-context john-context --cluster=kubernetes --namespace=office --user=john`{{execute}}
<pre>  
Context "john-context" created.
</pre>

`kubectl config get-contexts`{{execute}}
<pre>
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          john-context                  kubernetes   john               office
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin
</pre>


`kubectl --context=john-context run --image nginx:latest nginx`{{execute}}
<pre>
pod/nginx created
</pre>

`kubectl --context=john-context get pods --namespace office`{{execute}}
NAME    READY   STATUS              RESTARTS   AGE
nginx   0/1     ContainerCreating   0          40s

`kubectl --context=john-context get pods --namespace=default`{{execute}}
<pre>
Error from server (Forbidden): pods is forbidden: User "john" cannot list resource "pods" in API group "" inthe namespace "default"
</pre>

Literature: 
https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/practice-questions-answers/cluster-maintenance/backup-etcd/etcd-backup-and-restore.md