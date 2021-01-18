# kubectl get pod postgresql -n alpha -o yaml |grep " containerPort: 5432" \
#  && kubectl get pod postgresql -n alpha -o yaml  |grep 'image: postgres:12.4' \
#  && kubectl get pod postgresql-env -n alpha |grep Running \
#  && kubectl get pod postgresql-env -n alpha -o yaml |grep "containerPort: 5432" \
#  && kubectl get pod postgresql-env -n alpha -o yaml  |grep 'image: postgres:12.4' \
#  && kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_DB: postgresdb" \
#  && kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_USER: postgresadmin" \
#  && kubectl get cm postgresql-configmap -n alpha -o yaml | grep "POSTGRES_PASSWORD: admin123" \
#  && kubectl get pod postgresql-cm -n alpha | grep Running \
#  && kubectl get pod postgresql-cm -n alpha -o yaml |grep configMapRef -A1 | grep postgresql-cm \
#  && kubectl get cm postgresql-configmap-nopass -n alpha -o yaml | grep "POSTGRES_DB: postgresdb" \
#  && kubectl get cm postgresql-configmap-nopass -n alpha -o yaml | grep "POSTGRES_USER: postgresadmin" \
#  && kubectl get secret postgresql-secret -n alpha -o yaml | grep POSTGRES_PASSWORD: \
#  && kubectl get pod postgresql-cm-secret -n alpha | grep Running \
#  && kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep configMapRef -A1 | grep postgresql-configmap-nopass \
#  && kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep secretRef: -A1| grep postgresql-secret \
#  && kubectl get svc postgresql-webservice -n alpha |grep 5432 && echo "done" > /var/log/02-check.log

#kubectl get pod postgresql -n alpha -o yaml |grep " containerPort: 5432" \
#  && kubectl get pod postgresql-cm-secret -n alpha | grep Running \
#  && kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep configMapRef -A1 | grep postgresql-configmap-nopass \
#  && kubectl get pod postgresql-cm-secret -n alpha -o yaml |grep secretRef: -A1| grep postgresql-secret \
#  && kubectl get svc postgresql-webservice -n alpha |grep 5432 && echo "done" > /var/log/02-check.log
# cat  /var/log/02-check.log  | grep "done" && echo "done"

echo "done"
