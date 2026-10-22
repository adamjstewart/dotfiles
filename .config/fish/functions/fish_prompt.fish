# Override uv's default uncolored prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

function fish_prompt -d 'define the appearance of the command line prompt'
    # (virtual env)
    if test -n "$VIRTUAL_ENV_PROMPT"
        echo -ns '(' (set_color purple) "$VIRTUAL_ENV_PROMPT" (set_color --reset) ') '
    end

    # [HH:MM:SS] execution time of previous command
    set --local ms $CMD_DURATION
    set --local ss (math --scale 0 $ms/1000 % 60)
    set --local mm (math --scale 0 $ms/1000/60 % 60)
    set --local hh (math --scale 0 $mm/1000/60/60 % 100)
    echo -ns [ (set_color blue) (printf "%02d:%02d:%02d" $hh $mm $ss) (set_color --reset) ] ' '

    # user@host
    echo -ns (set_color cyan) $USER (set_color --reset) @ (set_color green) (prompt_hostname) ' '

    # path
    echo -ns (set_color yellow) (prompt_pwd -d 0)

    # (git)
    set -l whitelist Vesuvius
    if contains (hostname) $whitelist
        echo -ns (set_color --reset) (fish_git_prompt)
    end

    # >
    echo -s \n (set_color --reset) '> '
end
