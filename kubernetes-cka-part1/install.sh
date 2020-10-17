#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"


source ~/.bashrc

echo "done" >> /opt/.clusterstarted