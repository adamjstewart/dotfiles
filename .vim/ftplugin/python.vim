" Python-specific vim settings

" Black line length limit
set colorcolumn=89

" Spack has a custom black configuration
autocmd BufNewFile,BufRead ~/spack/* set colorcolumn=100

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Long docstrings can break syntax highlighting in Python
" Parse from the beginning of the file for best results
autocmd BufEnter * :syntax sync fromstart
