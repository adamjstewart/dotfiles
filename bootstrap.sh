#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

cd "$(dirname "$BASH_SOURCE")"

git pull origin master

function syncDotfiles {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
          --exclude "README.md" -avh --no-perms . ~
    source ~/.bashrc
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

