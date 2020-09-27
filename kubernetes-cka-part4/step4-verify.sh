#!/usr/bin/env bash

kubectl get svc frontend -n delta -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n delta -o yaml |grep "targetPort: 80" && echo "done" 
