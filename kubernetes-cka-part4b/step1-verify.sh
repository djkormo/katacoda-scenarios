#!/usr/bin/env bash


curl -sSf http://localhost:30001 > /tmp/alpha.log \
&& kubectl get svc frontend -n alpha -o yaml |grep "nodePort: 30001" \
&& cat /tmp/alpha.log | grep "<title>Guestbook</title>" \
&&  echo "done"
