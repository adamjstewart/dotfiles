#!/usr/bin/env bash
#
# bash/zsh svn prompt support
#
# This script allows you to see repository status in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.svn-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.svn-prompt.sh
#    3a) If svn is your only VCS, set your PROMPT_COMMAND
#        like so:
#        Bash: PROMPT_COMMAND="__svn_ps1 '$pre' '$post' '$mid'"
#    3b) Alternatively, if you use both git and svn, set your
#        PROMPT_COMMAND like so:
#        Bash: PROMPT_COMMAND="__git_svn_ps1 '$pre' '$post' '$mid'"
#
# The repository status will be displayed only if you are currently in a
# git repository. The %s token is the placeholder for the shown status.
#
# The prompt status always includes the current branch name.
#
# This script is modeled after Shawn O. Pearce's git prompt support.

__svn_ps1 ()
{
    local ps1pc_start="$1"
    local ps1pc_end="$2"
    local printf_format="$3"
    local svnstring=""

    if [[ -d .svn ]]
    then
        local status=$(svn status)

        # TODO: better branch detection
        local branch='trunk'
        local unstaged=''
        local staged=''
        local untracked=''

        # Check for unstaged changes
        if [[ $(echo "$status" | grep '^\s*[CDMR!]') ]]
        then
            unstaged='*'
        fi

        # Check for staged changes
        if [[ $(echo "$status" | grep '^\s*A') ]]
        then
            staged='+'
        fi

        # Check for untracked files
        if [[ $(echo "$status" | grep '^\s*\?') ]]
        then
            untracked='%'
        fi

        local state="$unstaged$staged$untracked"
        local svnstring="$branch${state:+ $state}"

        printf -v svnstring -- "$printf_format" "$svnstring"
    fi

    PS1="$ps1pc_start$svnstring$ps1pc_end"
}

__git_svn_ps1 ()
{
    if [[ -d .svn ]]
    then
        __svn_ps1 "$@"
    else
        __git_ps1 "$@"
    fi
}
