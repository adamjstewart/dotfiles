#!/usr/bin/env bash

# .bash_aliases

# Contains all user aliases

# OS Specific Aliases
kernel=$(uname)
case "$kernel" in
    'Darwin') # macOS
        colorFlag='-G'
        alias df='df -h'
        alias updatedb='sudo /usr/libexec/locate.updatedb'
        ;;
    'Linux')
        colorFlag='--color'
        alias df='df -Th --total'
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

# Slurm Aliases
alias sq='squeue -o "%.8i %.9P %.16j %.8u %.2t %.10M %.5D %.4C %.10m %.15b %R"'

# System Aliases
alias g='git'
alias p='python3'
alias mkdirp='mkdir -p'
alias grep='grep --color=auto -I'
alias egrep='egrep --color=auto -I'
alias fgrep='fgrep --color=auto -I'
alias free='free -mt'
alias ps='ps aux'
alias bc='bc -ql'
alias ftp='lftp'
alias wget='wget -c'

# Grep processes for one of a particular name
alias psg='ps | grep -v grep | grep -i -e VSZ -e'

# List most commonly used commands
alias common="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl |  head"

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

# Like `which`, but for libraries
alias whichlib='/sbin/ldconfig -p | grep'

if [[ -d "/scratch/$USER" ]]
then
    alias csc="cd /scratch/$USER"
elif [[ -d "/scratch/sciteam/$USER" ]]
then
    alias csc="cd /scratch/sciteam/$USER"
elif [[ -d "$HOME/Downloads" ]]
then
    alias csc="cd $HOME/Downloads"
fi

# Spack Aliases
alias s='spack'
alias spack2='python2 $(which spack)'
alias spack3='python3 $(which spack)'

if [[ "$SPACK_ROOT" ]]
then
    alias cs='cd $SPACK_ROOT'
    alias csv='cd $SPACK_ROOT/var/spack/repos/builtin/packages'
    alias csl='cd $SPACK_ROOT/lib/spack/spack'
    alias csd='cd $SPACK_ROOT/lib/spack/docs'
    alias csq='cd $SPACK_ROOT/share/spack/qa'
    alias cso='cd $SPACK_ROOT/opt/spack'
fi
