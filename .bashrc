#!/usr/bin/env bash

# .bashrc

# Sourced when an interactive shell that is not a login shell is started
# On Linux, this occurs when a new Terminal is opened

# See `man shopt`
shopt -s checkhash checkwinsize cmdhist dirspell dotglob extglob globstar histappend no_empty_cmd_completion nocaseglob nullglob

# Source all user setting files
# Note: .git-prompt.sh must come before .svn-prompt.sh and .bash_prompt
# Note: .svn-prompt.sh must come before .bash_prompt
# Note: .bash_exports must come before .bash_aliases
# Note: .bash_aliases must come before .bash_functions
for file in ~/.git-{completion.bash,prompt.sh} ~/.svn-prompt.sh ~/.bash_{exports,aliases,functions,prompt}
do
    if [[ -f "$file" ]]
    then
        source "$file"
    fi
done

# Source spack setting files
for file in "$SPACK_ROOT/share/spack/spack-completion.bash"
do
    if [[ -f "$file" ]]
    then
        source "$file"
    fi
done

# This user file-creation mask prevents others from seeing my work
umask u=rwx,g=rx,o=

# Add tab completion for alias based on existing aliases
complete -o "nospace" -W "$(alias | cut -d ' ' -f 2 | cut -d '=' -f 1)" alias

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f 2-)" ssh scp ftp lftp sftp

# Tab completion for cd should list directories only
complete -d cd c

# Tab completion for extract in .bash_functions should only list files with
# extensions denoting that they are compressed. This requires Extended Globs.
complete -f -X '!*.@(gz|bz2|xz|tgz|tbz2|txz|tar|zip|rar|lzma|Z|7z|exe)' extract

# Tab completion for qsub should only list .pbs files
complete -f -X '!*.pbs' qsub

# macOS Sierra does not automatically load ssh keys stored in the keychain
kernel=$(uname)
case "$kernel" in
    'Darwin') # macOS
        ssh-add -A &> /dev/null;;
esac
