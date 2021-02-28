#!/usr/bin/env bash
  kubectl get nodes | grep 1.19 | grep Ready | wc -l | grep 2 \
    && kubectl get pod alone-pod web-server -n alone | grep Running |wc -l | grep 2 \
    && echo "done"