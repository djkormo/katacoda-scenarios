#!/usr/bin/env bash

kubectl get svc frontend -n alpha |grep 30001 &&  echo "done"
