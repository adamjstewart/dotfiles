" reStructuredText-specific vim settings

" Use three space indentation
setlocal tabstop=3
setlocal shiftwidth=3
setlocal softtabstop=3

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
