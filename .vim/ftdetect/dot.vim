" Graphviz-specific vim file type detection

" Use dot syntax highlighting for graphviz files
autocmd BufRead,BufNewFile *.gv,*.dot set filetype=dot
