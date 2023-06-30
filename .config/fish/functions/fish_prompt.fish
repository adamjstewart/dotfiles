function fish_prompt -d 'Write out the prompt'
    # [time]
    echo -n -s [ (set_color blue) (date '+%H:%M:%S') (set_color normal) ] ' '

    # user@host
    echo -n -s (set_color cyan) $USER (set_color normal) @ (set_color green) (prompt_hostname) ' '

    # path (git)
    echo -s (set_color yellow) (prompt_pwd -d 0) (set_color normal) (fish_git_prompt)

    # >
    echo -s (set_color normal) '> '
end
