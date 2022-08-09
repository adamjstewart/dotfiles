" Python-specific vim settings

" Long docstrings can break syntax highlighting in Python
" Parse from the beginning of the file for best results
autocmd BufEnter * :syntax sync fromstart
