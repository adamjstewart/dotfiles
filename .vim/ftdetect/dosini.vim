" INI-specific vim file type detection

" Use dosini syntax highlighting for .flake8/setup.cfg files
autocmd BufRead,BufNewFile .flake8,setup.cfg set filetype=dosini
