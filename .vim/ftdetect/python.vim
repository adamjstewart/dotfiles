" Python-specific vim file type detection

" SConstruct files are written in Python
autocmd BufRead,BufNewFile SConstruct set filetype=python
