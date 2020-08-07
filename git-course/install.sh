#!/bin/bash

apt install --yes apache2 
apt install --yes composer
apt install --yes emacs
apt install --yes lynx mc nano
sudo service apache2 status

cat <<EOF >~/.bashrc
git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\]\$(git_branch)\$ "
EOF

source ~/.bashrc