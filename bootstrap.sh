#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

OLDPWD_backup="$OLDPWD"
cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin master

rsync --exclude-from "exclude_list.txt" -avh --no-perms . ~

# Make sure .ssh permissions are correct
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

source ~/.bashrc

cd "$OLDPWD"
export OLDPWD="$OLDPWD_backup"
