" Python-specific vim settings

" Highlight column 80
setlocal colorcolumn=80

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
