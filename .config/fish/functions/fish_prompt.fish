function fish_prompt -d 'define the appearance of the command line prompt'
    # [time]
    echo -ns [ (set_color blue) (date '+%H:%M:%S') (set_color normal) ] ' '

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
