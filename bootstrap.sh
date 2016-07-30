#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin master

rsync --exclude-from "exclude_list.txt" -avh --no-perms . ~
source ~/.bashrc

# Sync Sublime Text settings files
kernel=$(uname)
case "$kernel" in
    'Darwin') # macOS
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
    rsync --include "*.sublime-settings" --exclude "*" -avh --no-perms "sublime-settings" "$sublimeDir"
fi

cd "$OLDPWD"

