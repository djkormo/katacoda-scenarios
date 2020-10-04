#!/usr/bin/env bash

[ -f /opt/etcd-backup.db ] | [ -d /var/lib/etcd-backup ] \
  && kubectl get  pods -n default | grep nginx | wc -l | grep 3 \
  && echo "done"
