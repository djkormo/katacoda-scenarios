#!/bin/bash
echo off
apt-get update

# Start Kubernetes
echo "Starting cluster"
# launch.sh


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

cat <<EOF >~/.bashrc
git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\]\$(git_branch)\$ "
EOF

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

echo "done" >> /opt/.clusterstarted