#!/bin/bash

waitForCompletion() {
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  while true; do
    sudo grep -i "done" $1 &> /dev/null
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
}

showProgress()
{
  echo -n "Starting cluster"
  waitForCompletion /opt/.clusterstarted
  echo -n "Upgrading cluster"
  waitForCompletion /opt/.clusterupgraded
  echo -n "Upgrading nodes"
  waitForCompletion /opt/.nodeupgraded
  #echo -n "Installing Tekton CLI"
  #waitForCompletion /opt/.tkninstalled
  #echo -n "Waiting for pods to be ready"
  #waitForCompletion /opt/.podsready
  #echo -n "Configuring ingress"
  #waitForCompletion /opt/.ingressconfigured
  # echo -n "Completing"
  # waitForCompletion /opt/.backgroundfinished
  echo "Ready"
  echo ""
}

showProgress

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

