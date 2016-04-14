#!/usr/bin/env bash

# .bash_functions

# Contains all user defined functions

# List files when changing directory
function c {
    cd "$@" && l
}

# Open Firefox in the background
#
# Websites with text fields that don't specify both the
# background and text colors show both as black.
# Setting GTK_THEME overrides this and allows the user
# to run dark theme globally but light theme for firefox.
# http://worldofgnome.org/running-gtk-applications-different-themes-per-app/
function ff {
    GTK_THEME=Adwaita:light firefox "$@" &> /dev/null &
}

# Pretty-prints one or more arrays
#
# Syntax: pretty_print array1[@] ...
function pretty_print {
    for arg in $@
    do
        local array=("${!arg}")
        echo -n "$arg: ["
        printf   "'%s'" "${array[0]}"
        printf ", '%s'" "${array[@]:1}"
        echo "]"
    done
}

# Extract any compressed file
#
# Chooses extraction utility based on file extension
function extract {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.gz|*.tgz)     tar xvzf   "$1" ;;
            *.tar.bz2|*.tbz2)   tar xvjf   "$1" ;;
            *.tar)              tar xvf    "$1" ;;
            *.gz)               gunzip     "$1" ;;
            *.bz2)              bunzip2    "$1" ;;
            *.zip)              unzip      "$1" ;;
            *.rar)              unrar x    "$1" ;;
            *.Z)                uncompress "$1" ;;
            *.7z)               7z x       "$1" ;;
            *)                  echo "Don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Better `man` for builtin commands
#
# Automatically jumps to the appropriate section
# of the Bash man page for builtin commands
function man {
    local search=''
    local name='bash'
    # Check type of the command
    case $(type -t "$1") in
        # Bash builtins
        'builtin')
            case "$1" in
                # Bash builtins with stand-alone man pages
                echo|false|kill|printf|pwd|test|true)
                    name="$1"
                    ;;
                # Special cases
                '.'|'[')
                    search=-p"^ {7,8}\\$1 .*\]"
                    ;;
                declare)
                    search=-p"^ {7}$1 \[.*"
                    ;;
                logout|times)
                    search=-p"^ {7}$1 "
                    ;;
                # Bash builtins without stand-alone man pages
                *)
                    search=-p"^ {7}$1 .*\[.*"
                    ;;
            esac
            ;;
        # Non bash builtins
        *)
            name="$1"
            ;;
    esac
    # Now run actual command `man` and search for string `search`
    LESS="$search" command man "$name"
}

