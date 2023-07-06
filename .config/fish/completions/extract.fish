complete -c extract -f -a '(complete -C"\'\' $(commandline -ct)" | string match -re "(?:/|\.tar.*|\.tgz|\.tbz.*|\.txz|\.zip|\.ZIP|\.whl|\.gz|\.bz2|\.xz|\.lzma|\.rar|\.Z|\.7z|\.exe)\$")'
