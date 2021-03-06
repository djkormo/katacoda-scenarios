echo off
sleep 1; bash /usr/local/bin/wait.sh

free_time()
{
    uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print 60-$2" "$3 }'
}
git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
prompt() {
export PS1="$(free_time) \[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\]\$(git_branch)\$ "
}
PROMPT_COMMAND=prompt
echo "Almost ready!!!"

sleep 10;
source ~/.bashrc

echo "start" >> /opt/.krewinstall

install-krew.sh >> /opt/.krewinstall

export PATH="${PATH}:${HOME}/.krew/bin" >> /opt/.krewinstall

echo "done" >> /opt/.krewinstall


clear

kubectl wait node --all --for=condition=Ready --timeout=3m

watch kubectl get nodes 