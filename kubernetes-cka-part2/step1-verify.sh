kubectl get pod web -n alpha |grep Running \
  && kubectl get pod web -n alpha -o yaml  |grep 'image: nginx:1.11.9-alpine' \
  && kubectl get svc webservice -n alpha |grep 80 \
  && kubectl get svc webservice -n alpha |grep 443 &&  echo "done"> /var/log/01-check.log

cat 01-check.log  | grep "done" && echo "done"