#!/bin/bash

apt-get update


cat <<EOF >~/.bashrc
git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\]\$(git_branch)\$ "
EOF

source ~/.bashrc

clear