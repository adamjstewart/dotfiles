# Contains settings for various prompts

# Best Terminal Background Colors:
#   Monokai  [Sublime Text] (hex: #272822; rgb: 39,40,34; hsv:  70, 15,16)
#   Dark Aubergine [Ubuntu] (hex: #2C001E; rgb: 44, 0,30; hsv: 319,100,17)

# Text settings: Menlo Regular 12pt

# Make sure this is an interactive prompt before running tput
# This is needed to avoid problems with scp
if tty -s
then
    bold=$(   tput bold)
    reset=$(  tput sgr0)

    black=$(  tput setaf 0)
    red=$(    tput setaf 1)
    green=$(  tput setaf 2)
    yellow=$( tput setaf 3)
    blue=$(   tput setaf 4)
    magenta=$(tput setaf 5)
    cyan=$(   tput setaf 6)
    white=$(  tput setaf 7)
else
    bold=''
    reset='\e[0m'

    black='\e[0;30m'
    red='\e[0;31m'
    green='\e[0;32m'
    yellow='\e[0;33m'
    blue='\e[0;34m'
    magenta='\e[0;35m'
    cyan='\e[0;36m'
    white='\e[0;37m'
fi

# Wrap meta-characters in square brackets to prevent bash
# from using them to calculate the width of the prompt
bold="\[$bold\]"
reset="\[$reset\]"

black="\[$black\]"
red="\[$red\]"
green="\[$green\]"
yellow="\[$yellow\]"
blue="\[$blue\]"
magenta="\[$magenta\]"
cyan="\[$cyan\]"
white="\[$white\]"

# Define bash prompt (PS1/PROMPT_COMMAND)

# PS1 sets a static bash prompt
# PROMPT_COMMAND sets a dynamic bash prompt

# [time] user@host:pwd (branch)
# $

# Default varies by OS
pre="$reset"

pre+="$white["
pre+="$blue\T"   # time
pre+="$white] "

pre+="$cyan\u"   # username
pre+="$white@"
pre+="$green\h " # hostname
pre+="$yellow\w" # pwd

mid=" $white("
mid+="$red%s"
mid+="$white)"

post="$reset\n\$ "

# See .git-prompt.sh and .svn-prompt.sh for details
PROMPT_COMMAND="__git_svn_ps1 '$pre' '$post' '$mid'"

export PROMPT_COMMAND

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Disable git/svn prompt
#
# Useful on slow NFS filesystems
function fastprompt {
    unset PROMPT_COMMAND
    PS1="$pre$post"
}

# Reenable git/svn prompt
function slowprompt {
    unset PS1
    PROMPT_COMMAND="__git_svn_ps1 '$pre' '$post' '$mid'"
}

# Define continuation prompt (PS2)

# This prompt is used when a command, such as a for loop or if statement,
# is written over multiple lines at the command prompt
# Same as default
PS2='> '

export PS2

# Define select command prompt (PS3)

# This prompt is used when the select command is called to ask for user input
# Default was '#?'
PS3='Select an option: '

export PS3

# Define execution trace prompt (PS4)

# This prompt is used when execution tracing is enabled (set -x)
# The first character is replicated to represent multiple levels of indirection
# Default was '+ '. Credit goes to:
# http://www.runscripts.com/support/guides/scripting/bash/debugging-bash/verbose-tracing
PS4=$'+ $(date +"%Y-%m-%d %H:%M:%S"): ' # + date time
PS4+=$'+${SECONDS}s: '                  # script execution time so far
PS4+=$'${BASH_SOURCE[0]##*/}: '         # file name
PS4+=$'Line ${LINENO}\n'                # line number
PS4+=$'> ${BASH_COMMAND}\n'             # command before expansion (set -v)
PS4+=$'> '                              # command after expansion

export PS4

