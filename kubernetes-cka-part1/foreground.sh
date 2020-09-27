#echo off
#echo "The IP address for this environment is [[HOST_IP]]"
#echo "The URL to access Port 80 is [[HOST_SxeUBDOMAIN]]-80-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo off
sleep 10; bash /usr/local/bin/wait.sh

free_time()
{
    #awk "{print $1}" /proc/uptime
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

clear