" Python-specific vim settings

" Highlight column 80
setlocal colorcolumn=80

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Long docstrings can break syntax highlighting in Python
" Search more lines than the default
syntax sync minlines=75
