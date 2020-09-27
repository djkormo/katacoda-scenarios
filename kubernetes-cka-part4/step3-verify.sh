#!/usr/bin/env bash

kubectl get svc frontend -n gamma -o yaml |grep "nodePort: 30001" && kubectl get svc frontend -n gamma -o yaml |grep "targetPort: 80" && echo "done" 
