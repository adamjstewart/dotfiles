" reStructuredText-specific vim settings

" Turn on spell checking
set spell

" Strip trailing whitespaces upon write
autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
