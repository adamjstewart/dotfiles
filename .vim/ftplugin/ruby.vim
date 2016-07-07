" Ruby-specific vim settings

" Use two space indentation
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
