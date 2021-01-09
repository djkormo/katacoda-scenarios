free_time()
{
    #awk "{print $1}" /proc/uptime
    uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print 60-$2" "$3 }'
}
git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
export PS1="$(free_time) \[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\]\$(git_branch)\$ "
export do=" --dry-run=client -o yaml"
