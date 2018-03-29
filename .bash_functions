#!/usr/bin/env bash

# .bash_functions

# Contains all user defined functions

# List files when changing directory
function c {
    cd "$@" && l
}

# Make directory and cd into it
function mcd {
    mkdir -p "$1"
    cd "$1"
}

# Returns the length of a string
function length {
    echo "${#1}"
}

# Go up a certain number of directories
#
# Usage: up [NUMBER]
function up {
    local counter="$1"

    # Default to 1 if counter not set
    if [[ -z "$counter" ]]
    then
        counter=1
    fi

    # Start from current directory
    local nwd=$(pwd)
    until [[ "$counter" -lt 1 ]]
    do
        nwd=$(dirname "$nwd")
        let counter-=1
    done
    cd "$nwd"
}

# Backup the current directory
#
# A directory of the same name is made in Dropbox
#
# Usage: backup
function backup {
    local from="$PWD"
    local to=~/Dropbox

    rsync -avh "$from" "$to"
}

# Send files or directories to the trash
#
# Files end up in ~/.Trash
#
# Usage: trash [files...] [directories...]
function trash {
    # Make the directory if one does not already exist
    mkdir -pv ~/.Trash

    # Move all files to the trash
    local kernel=$(uname)
    case "$kernel" in
        'Darwin') # macOS
            mv -fv -- "$@" ~/.Trash;;
        'Linux')
            mv --force --verbose --backup=numbered -- "$@" ~/.Trash;;
        *)
            echo "Unknown OS: $kernel";;
    esac
}

# Empty the trash
#
# By default, deletes anything more than a week old
# Accepts an optional argument to change the length of time
# See the `-atime` section of `man find` for more information
#
# Usage: empty [[+-]n[smhdw]]
function empty {
    # Default to anything older than 1 week
    local mtime='+1w'

    # Accept optional mtime flag
    if [[ "$1" ]]
    then
        mtime="$1"
    fi

    # Delete the old files
    find ~/.Trash/* -depth -mtime "$mtime" -exec rm -rf '{}' \;
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
#
# Can extract multiple files
#
# TODO: Add the following options
# TODO:     Ignore non-compressed files
# TODO:     Ignore already uncompressed files
# TODO:     Overwrite and re-extract already uncompressed files
function extract {
    if [[ "$#" -eq 0 ]]
    then
        echo "Usage: extract FILE [FILE ...]"
    fi

    # Loop through all files
    for file in "$@"
    do
        if [[ -f "$file" ]]; then
            case "$file" in
                *.tar.gz|*.tgz)     tar xvzf   "$file" ;;
                *.tar.bz2|*.tbz2)   tar xvjf   "$file" ;;
                *.tar.xz|*.txz)     tar xvJf   "$file" ;;
                *.tar.Z)            tar xvZf   "$file" ;;
                *.tar)              tar xvf    "$file" ;;
                *.gz)               gunzip     "$file" ;;
                *.bz2)              bunzip2    "$file" ;;
                *.xz)               unxz       "$file" ;;
                *.zip)              unzip      "$file" ;;
                *.rar)              unrar x    "$file" ;;
                *.lzma)             unlzma     "$file" ;;
                *.Z)                uncompress "$file" ;;
                *.7z)               7z x       "$file" ;;
                *.exe)              cabextract "$file" ;;
                *)                  echo "extract: '$file' - unknown archive method" ;;
            esac
        else
            echo "extract: '$file' - file does not exist"
        fi
    done
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
