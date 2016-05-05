#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

cd "$(dirname "$BASH_SOURCE")"

git pull origin master

function syncDotfiles {
    rsync --exclude-from "exclude_list.txt" -avh --no-perms . ~
    source ~/.bashrc

    # Sync Sublime Text settings files
    kernel=$(uname)
    case "$kernel" in
        'Darwin') # OS X
            sublimeDir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
            ;;
        'Linux')
            sublimeDir="$HOME/.config/sublime-text-3/Packages/User"
            ;;
        *)
            echo "Unknown OS: $kernel"
            ;;
    esac

    if [[ -d "$sublimeDir" ]]
    then
        rsync --include "*.sublime-settings" --exclude "*" -avh --no-perms . "$sublimeDir"
    fi
}

if [[ "$1" == "--force" || "$1" == "-f" ]]
then
    syncDotfiles
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo

    if [[ "$REPLY" =~ ^[Yy]$ ]]
    then
        syncDotfiles
    else
        echo "Aborting..."
    fi
fi

unset syncDotfiles

cd "$OLDPWD"

