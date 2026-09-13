function fish_prompt -d 'define the appearance of the command line prompt'
    # [HH:MM:SS] execution time of previous command
    set --local ms $CMD_DURATION
    set --local ss (math --scale 0 $ms/1000 % 60)
    set --local mm (math --scale 0 $ms/1000/60 % 60)
    set --local hh (math --scale 0 $mm/1000/60/60)
    echo -ns [ (set_color blue) (printf "%02d:%02d:%02d" $hh $mm $ss) (set_color normal) ] ' '

    # user@host
    echo -ns (set_color cyan) $USER (set_color normal) @ (set_color green) (prompt_hostname) ' '

    # path
    echo -ns (set_color yellow) (prompt_pwd -d 0)

    # (git)
    set -l whitelist Vesuvius
    if contains (hostname) $whitelist
        echo -ns (set_color normal) (fish_git_prompt)
    end

    # >
    echo -s \n (set_color normal) '> '
end
