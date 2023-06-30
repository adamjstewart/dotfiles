function up -d 'go up a certain number of directories'
    set -l nwd $PWD
    for i in (seq 1 $argv)
        set nwd (path dirname $nwd)
    end
    cd $nwd
end
