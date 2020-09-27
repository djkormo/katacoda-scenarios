free_time()
{
    #awk "{print $1}" /proc/uptime
    uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 }'
}
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="$(free_time) ${GREEN}\u@\h ${RESET} :"