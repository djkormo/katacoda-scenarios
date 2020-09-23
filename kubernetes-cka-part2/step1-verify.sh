#!/usr/bin/env bash
#[ -d ~/.kube/config ] && echo "done"

#kubectl get nodes | grep 1.19.0 | grep Ready | wc -l | grep 2 && echo "done"
kubectl get svc web -n alpha |grep 80 && kubectl get svc web -n alpha |grep 443 &&  echo "done"

echo "done"