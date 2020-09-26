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
    awk '/MemFree/{print $2}' /proc/meminfo
}


PS1="${GREEN}my prompt${RESET}> "
PS1="${GREEN}\u@\h$ $(free_time) {RESET}> 
