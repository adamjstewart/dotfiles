#!/usr/bin/env bash

# .bash_exports

# Contains all exported environment variables

# OS Specific Aliases
kernel=$(uname)
case "$kernel" in
    'Darwin') # macOS
        # The macOS/FreeBSD version of ls uses LSCOLORS
        export LSCOLORS='exfxcxdxbxegedabagexex'
        # In Bash 4.3+, the Readline utility uses LS_COLORS when colored-stats is set to "on"
        export LS_COLORS='di=34:fi=0:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=34:ow=34'
        ;;
    'Linux')
        # The Linux version of ls uses LS_COLORS
        export LS_COLORS='di=34:fi=0:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=34:ow=34'
        ;;
    *)
        echo "Unknown OS: $kernel"
        ;;
esac

if [[ ! $PATH =~ ~/bin ]]
then
    export PATH="$HOME/bin:$PATH"
fi

# Set default text editor
export EDITOR='vim'

# Less settings
export LESS='--ignore-case --RAW-CONTROL-CHARS'

# Bash history settings
export HISTSIZE='32768'
export HISTFILESIZE="$HISTSIZE"
export HISTCONTROL='ignoreboth'

# Language settings
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Spack
if [[ -d "$HOME/spack" ]]
then
    if [[ -z "$SPACK_ROOT" ]]
    then
        export SPACK_ROOT="$HOME/spack"
    fi

    export SPACK_SKIP_MODULES=true
fi

SPACK_VIEW="$SPACK_ROOT/var/spack/environments/system/.spack-env/view"
if [[ -d "$SPACK_VIEW" ]]
then
    export PATH="$SPACK_VIEW/bin:$PATH"

    for path in $SPACK_VIEW/lib/python*/site-packages
    do
        export PYTHONPATH+=":$path"
    done
    export DYLD_FALLBACK_LIBRARY_PATH+=":$SPACK_VIEW/lib"

    # Trailing colon allows `man' to search system locations as well
    export MANPATH+=":$SPACK_VIEW/share/man:$SPACK_VIEW/man:"

    export SPATIALINDEX_C_LIBRARY="$SPACK_VIEW/lib/libspatialindex_c.dylib"
fi

# GPG settings
export GPG_TTY=$(tty)
