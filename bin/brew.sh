#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Install Homebrew if it isn't already installed
if ! which -s brew
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update to the latest version of Homebrew
brew update

# Upgrade any already-installed forumulae
brew upgrade --all

# Install software installation tools
brew install automake
brew install cmake

# Install compilers
brew install gcc

# Install Bash 4 and set it as the default shell
brew install bash
brew tap homebrew/versions
brew install bash-completion2

if ! fgrep -q '/usr/local/bin/bash' /etc/shells
then
    echo 'Setting Bash 4 as the default login shell'
    sudo echo '/usr/local/bin/bash' >> /etc/shells
    chsh -s /usr/local/bin/bash
fi

# Install various compression/decompression libraries
brew install xz
brew install unrar
brew install p7zip
brew install cabextract

# Install GNU tools
brew install gnu-time --with-default-names
brew install gnu-sed  --with-default-names
brew install homebrew/dupes/grep --with-default-names

# Install more recent versions of macOS tools
brew install vim --with-override-system-vi

# Install various VCS
brew install git
brew install hg
brew install subversion

# Install other software
brew install wget
brew install dos2unix
brew install ssh-copy-id
brew install graphviz

# Remove outdated versions from the Cellar
brew cleanup

