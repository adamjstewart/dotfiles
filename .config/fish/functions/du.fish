function du -d 'display disk usage statistics'
    command du -chd 1 $argv | sort -hr
end
