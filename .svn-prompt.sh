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
# If you set GIT_COMPATIBILITY_MODE to a nonempty value, the svn prompt
# will act like the git prompt, with (*) representing unstaged changes,
# (+) representing staged changes, and (%) representing untracked files.
# Otherwise, use the symbols reported by svn status.
#
# This script is modeled after Shawn O. Pearce's git prompt support.

__in_svn_repo ()
{
    # Get the physical current working directory (all symbolic links resolved)
    local dir="$(pwd -P)"

    while [ "$dir" != "/" ]
    do
        if [ -d "$dir/.svn" ]
        then
            return 0
        fi

        dir="$(dirname "$dir")"
    done

    return 1
}

__svn_ps1 ()
{
    local ps1pc_start="$1"
    local ps1pc_end="$2"
    local printf_format="$3"
    local svnstring=""

    if __in_svn_repo
    then
        local status=$(svn status)

        # TODO: better branch detection
        local branch='trunk'

        if [ "$GIT_COMPATIBILITY_MODE" ]
        then
            local unstaged=''
            local staged=''
            local untracked=''

            if [ "$GIT_PS1_SHOWDIRTYSTATE" ]
            then
                # Check for unstaged changes
                if [ "$(echo "$status" | grep '^[CDMR!]')" ]
                then
                    unstaged='*'
                fi

                # Check for staged changes
                if [ "$(echo "$status" | grep '^A')" ]
                then
                    staged='+'
                fi
            fi

            if [ "$GIT_PS1_SHOWUNTRACKEDFILES" ]
            then
                # Check for untracked files
                if [ "$(echo "$status" | grep '^\?')" ]
                then
                    untracked='%'
                fi
            fi

            local state="$unstaged$staged$untracked"
        else
            # The first seven columns in the output are each one character wide,
            # and each column gives you information about a different aspect of
            # each working copy item.
            #
            # http://svnbook.red-bean.com/en/1.7/svn.ref.svn.c.status.html
            local state=$(svn status | cut -c -7 | fold -w 1 | sort | uniq | tr -d ' \n')
        fi

        local svnstring="$branch${state:+ $state}"

        printf -v svnstring -- "$printf_format" "$svnstring"
    fi

    PS1="$ps1pc_start$svnstring$ps1pc_end"
}

__git_svn_ps1 ()
{
    if __in_svn_repo
    then
        __svn_ps1 "$@"
    else
        __git_ps1 "$@"
    fi
}
