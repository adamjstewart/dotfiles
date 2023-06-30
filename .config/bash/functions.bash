# Contains all user defined functions

# List files when changing directory
function c {
    cd "$@" && l
}

# Limit depth of du and sort results by size
function du {
    command du -ch -d 1 "$@" | sort -hr
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
                *.tar.bz2|*.tbz*)   tar xvjf   "$file" ;;
                *.tar.xz|*.txz)     tar xvJf   "$file" ;;
                *.tar.Z)            tar xvZf   "$file" ;;
                *.tar)              tar xvf    "$file" ;;
                *.gz)               gunzip -k  "$file" ;;
                *.bz2)              bunzip2 -k "$file" ;;
                *.xz)               unxz -k    "$file" ;;
                *.zip|*.ZIP|*.whl)  unzip      "$file" ;;
                *.rar)              unrar x    "$file" ;;
                *.lzma)             unlzma -k  "$file" ;;
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
                echo|false|kill|printf|pwd|test|true|\[)
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
