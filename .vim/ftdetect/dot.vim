" DOT-specific vim file type detection

" Use dot syntax highlighting for graphviz files
autocmd BufRead,BufNewFile *.gv,*.dot,*.ladot set filetype=dot
