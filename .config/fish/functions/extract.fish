function extract -d 'extract any compressed file'
    for file in $argv
        switch $file
            case '*.tar*' '*.tgz' '*.tbz*' '*.txz'
                tar xvaf $file
            case '*.zip' '*.ZIP' '*.whl'
                unzip $file
            case '*.gz'
                gunzip -kv $file
            case '*.bz2'
                bunzip2 -kv $file
            case '*.xz'
                unxz -kv $file
            case '*.lzma'
                unlzma -kv $file
            case '*.rar'
                unrar x $file
            case '*.Z'
                uncompress $file
            case '*.7z'
                7z x $file
            case '*.exe'
                cabextract $file
            case '*'
                echo "extract: '$file' - unknown archive method"
        end
    end
end
