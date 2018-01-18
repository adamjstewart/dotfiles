" YAML-specific vim settings

" Use two space indentation
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
