# editor
set -gx EDITOR vim

# fish
set -gx __fish_git_prompt_showdirtystate true
set -gx __fish_git_prompt_showuntrackedfiles true
set -gx __fish_git_prompt_showstashstate true
set -gx __fish_git_prompt_showcolorhints true
set -gx __fish_git_prompt_color_flags red
set -gx __fish_git_prompt_color_branch red

# spack
if test -e "$HOME/spack"
    set -gx SPACK_SKIP_MODULES true
end

set -l spack_view "$HOME/spack/var/spack/environments/system/.spack-env/view"
if test -e "$spack_view"
    fish_add_path "$spack_view/bin"
    set -gx DYLD_FALLBACK_LIBRARY_PATH "$spack_view"/lib*
    set -gx MANPATH "$spack_view/share/man" "$spack_view/man" "$MANPATH"
    set -gx PYTHONPATH "$spack_view"/lib*/python*/site-packages "$PYTHONPATH"
    set -gx SPATIALINDEX_C_LIBRARY "$spack_view"/lib*/libspatialindex_c.*
end
