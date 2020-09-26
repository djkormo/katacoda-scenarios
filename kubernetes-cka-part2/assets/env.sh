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

# https://www.howtogeek.com/307701/how-to-customize-and-colorize-your-bash-prompt/
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization

free_mem()
{
    awk '/MemFree/{print $2}' /proc/meminfo
}

free_time()
{
    uptime -p 
}

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="$(free_time) ${GREEN}\u@\h ${RESET}:"
