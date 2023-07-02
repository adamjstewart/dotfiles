# bc
abbr -a bc bc -l

# cd
abbr -a -- - c -
abbr -a -- .. c ..

if test -e $HOME/Downloads
    abbr -a csc c $HOME/Downloads
end

# df
abbr -a df df -H

# git
abbr -a g git

# ls
abbr -a l ls
abbr -a la ls -A
abbr -a ll ls -lhA
abbr -a l1 ls -1
abbr -a lf ls -1f

# python
abbr -a p python3

# slurm
abbr -a sq squeue -o "%.8i %.9P %.16j %.8u %.2t %.10M %.5D %.4C %.10m %.15b %R" -S -i

# spack
abbr -a s spack

if test -e $HOME/spack
    abbr -a cs cd $HOME/spack
    abbr -a csv cd $HOME/spack/var/spack/repos/builtin/packages
    abbr -a csl cd $HOME/spack/lib/spack/spack
    abbr -a csd cd $HOME/spack/lib/spack/docs
end

# vim
abbr -a v vim

# wget
abbr -a wget wget -c
