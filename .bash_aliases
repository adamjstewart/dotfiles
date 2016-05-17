#!/usr/bin/env bash

# .bash_aliases

# Contains all user aliases

# OS Specific Aliases
kernel=$(uname)
case "$kernel" in
    'Darwin') # OS X
        colorFlag='-G'
        alias updatedb='sudo /usr/libexec/locate.updatedb'
        ;;
    'Linux')
        colorFlag='--color'
        alias trash='mv --verbose -f --backup=numbered --target-directory $HOME/.Trash'
        alias empty='find "$HOME/.Trash" -mtime +2 -delete'
        alias open='xdg-open'
        ;;
    *)
        echo "Unknown OS: $kernel"
        ;;
esac

# ls Aliases
alias l="ls $colorFlag"
alias la='l -A'     # prints hidden files
alias ll='l -l -h'  # prints files in long list format
alias l1='l -1'     # prints files in single column
alias lv='l -v'     # prints files sorted numerically
alias lf='l -1 -f'  # fastest way to list files in large directory, disables sorting

# cd Aliases
alias -- -='cd "$OLDPWD"'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# Text Editor Aliases
alias s='subl'
alias v='vim'
alias vd='vimdiff'
alias va='vim     "$HOME/.bash_aliases"'
alias ve='vim     "$HOME/.bash_exports"'
alias vf='vim     "$HOME/.bash_functions"'
alias vp='vim     "$HOME/.bash_prompt"'
alias vb='vim     "$HOME/.bashrc"'
alias sb='source  "$HOME/.bashrc"'
alias vv='vim     "$HOME/.vimrc"'
alias vi='vim     "$HOME/.inputrc"'
alias si='bind -f "$HOME/.inputrc"'

# System Aliases
alias cl='clear; ls'
alias env='env | sort'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h --max-depth=1'
alias bc='bc -ql'
alias ftp='lftp'

# Debugger Aliases
alias ddd='ddd --exec-window'
alias gdb='gdb -silent --args'

# SSH Aliases
if [[ -e "$HOME/.ssh/config" ]]
then
    ssh_hosts=($(grep "^Host" "$HOME/.ssh/config" | grep -v "[?*]" | cut -d " " -f 2-))
    for host in "${ssh_hosts[@]}"
    do
        alias $host="ssh $host"
    done
fi

# Work Aliases
alias dp22='xrandr --output DP2-2 --mode 3440x1440 --rate 50'
alias vsoft='vim /soft/softenv/latest/etc/softenv.db'
alias soft-ms='soft-msd -n && soft-msd && soft-msc'

if [[ -d /soft/spack ]]
then
    alias cs='cd /soft/spack'
elif [[ -d ~/spack ]]
then
    alias cs='cd ~/spack'
fi

