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
        alias empty="find $HOME/.Trash -mtime +2 -delete"
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
alias -- -='cd -'
alias ..='  cd ..'
alias ..2=' cd ../..'
alias ..3=' cd ../../..'
alias ..4=' cd ../../../..'
alias ..5=' cd ../../../../..'

# Text Editor Aliases
alias v='vim'
alias vd='vimdiff'
alias va="vim     $HOME/.bash_aliases"
alias ve="vim     $HOME/.bash_exports"
alias vf="vim     $HOME/.bash_functions"
alias vp="vim     $HOME/.bash_prompt"
alias vb="vim     $HOME/.bashrc"
alias sb="source  $HOME/.bashrc"
alias vv="vim     $HOME/.vimrc"
alias vi="vim     $HOME/.inputrc"
alias si="bind -f $HOME/.inputrc"
alias s="subl"

# System Aliases
alias cl='clear; ls'
alias env='env | sort'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h --max-depth=1'
alias bc='bc -ql'

# Debugger Aliases
alias ddd='ddd --exec-window'
alias gdb='gdb -silent --args'

# Work Aliases
alias dp22='xrandr --output DP2-2 --mode 3440x1440 --rate 50'
alias vsoft='vim /soft/softenv/latest/etc/softenv.db'
alias soft-ms='soft-msd -n && soft-msd && soft-msc'

ssh_hosts=(blues fusion mcs)
for host in "${ssh_hosts[@]}"
do
    alias $host="ssh $host"
done

