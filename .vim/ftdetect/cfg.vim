" cfg-specific vim file type detection

" Use cfg syntax highlighting for .flake8/setup.cfg/requirements.txt files
autocmd BufRead,BufNewFile .flake8,setup.cfg,requirements.txt set filetype=cfg
