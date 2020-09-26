#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
launch.sh
echo "done" >> /opt/.clusterstarted

# create a vimrc
cat <<EOF >>.vimrc
" Created on $(date)
set nocompatible
syntax enable
filetype plugin indent on
set paste
set tabstop=2
set autoindent
EOF

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}


cat <<EOF >~/.bashrc
free_time()
{
    #awk "{print $1}" /proc/uptime
    uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 }'
}
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="$(free_time) ${GREEN}\u@\h ${RESET} :"
EOF

source ~/.bashrc

free_time()
{
    uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print 60-$2" "$3 }'
}

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1='$(free_time) ${GREEN}\u@\h${RESET}:'
