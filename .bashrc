#!/usr/bin/env bash

# .bashrc

# Sourced when an interactive shell that is not a login shell is started
# On Linux, this occurs when a new Terminal is opened

# Source all user setting files
for file in ~/.bash_{aliases,exports,functions,prompt}
do
    if [[ -f "$file" ]]
    then
        source "$file"
    fi
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# If set, minor errors in the spelling of a directory component in a cd command will be corrected. The errors checked for are transposed characters, a missing character, and one character too many. If a correction is found, the corrected filename is printed, and the command proceeds. This option is only used by interactive shells.
shopt -s cdspell
# If set, bash checks that a command found in the hash table exists before trying to execute it. If a hashed command no longer exists, a normal path search is performed.
shopt -s checkhash
# If set, bash checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, bash attempts to save all lines of a multiple-line command in the same history entry. This allows easy re-editing of multi-line commands.
shopt -s cmdhist
# If set, the extended pattern matching features described above under Pathname Expansion are enabled.
shopt -s extglob
# If set, and readline is being used, bash will not attempt to search the PATH for possible completions when completion is attempted on an empty line.
shopt -s no_empty_cmd_completion
# If set, bash matches filenames in a case-insensitive fashion when performing pathname expansion (see Pathname Expansion above).
shopt -s nocaseglob

