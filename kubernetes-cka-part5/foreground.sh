echo off
sleep 10; bash /usr/local/bin/wait.sh

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

kubectl create ns vol

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/storage-class.yaml

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/pv-local.yaml

kubectl apply -f https://raw.githubusercontent.com/djkormo/katacoda-scenarios/master/kubernetes-cka-part5/step1/pvc-local.yaml -n vol

clear