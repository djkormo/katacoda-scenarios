#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}

source ~/.bashrc

