function fish_right_prompt -d 'define the appearance of the right-side command line prompt'
    set -l sec (math -s 1 $CMD_DURATION / 1000 % 60)
    set -l min (math -s 0 $CMD_DURATION / 1000 / 60 % 60)
    set -l hrs (math -s 0 $CMD_DURATION / 1000 / 60 / 60)

    test $hrs -gt 0; and echo -ns $hrs h ' '
    test $min -gt 0; and echo -ns $min m ' '
    test $sec -gt 0; and echo -ns $sec s
end
