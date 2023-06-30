function du -d 'display disk usage statistics'
    command du -ch 1 $argv | sort -hr
end
