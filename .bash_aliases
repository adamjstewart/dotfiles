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
alias la='l -A'      # prints hidden files
alias ll='l -lhA'    # prints files in long list format
alias l1='l -1'      # prints files in single column
alias lt='l -lhAtr'  # prints files sorted by timestamp
alias lv='l -v'      # prints files sorted numerically
alias lf='l -1f'     # fastest way to list files in large directory, disables sorting

# cd Aliases
alias -- -='cd "$OLDPWD"'
alias ..='cd ..'

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
alias mkdirp='mkdir -p'
alias cl='clear'
alias grep='grep --color=auto'
alias df='df -Tha --total'
alias du='du -ch --max-depth=1 | sort -hr'
alias free='free -mt'
alias ps='ps auxf'
alias bc='bc -ql'
alias ftp='lftp'
alias wget='wget -c'

# Grep processes for one of a particular name
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# List most commonly used commands
alias common="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl |  head -n10"

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
alias vsoft='vim /soft/softenv/latest/etc/softenv.db'
alias soft-ms='soft-msd -n && soft-msd && soft-msc'

if [[ -d "$TMPDIR/$USER" ]]
then
    alias csc="cd $TMPDIR/$USER"
fi

# Spack Aliases
if [[ "$SPACK_ROOT" ]]
then
    alias cs="cd $SPACK_ROOT"
    alias csv="cd $SPACK_ROOT/var/spack/repos/builtin/packages"
    alias csl="cd $SPACK_ROOT/lib/spack/spack"
    alias cso="cd $SPACK_ROOT/opt/spack"
fi
