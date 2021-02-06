" Python-specific vim settings

" Highlight column 89
setlocal colorcolumn=89

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Long docstrings can break syntax highlighting in Python
" Parse from the beginning of the file for best results
autocmd BufEnter * :syntax sync fromstart
