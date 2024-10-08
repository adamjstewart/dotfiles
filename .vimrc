" Global vim settings for all file types
"
" See ~/.vim/colors/   for additional color scheme files
" See ~/.vim/ftplugin/ for language specific settings
" See ~/.vim/ftdetect/ for language specific file type detection
" See ~/.vim/indent/   for language specific indentation
" See ~/.vim/spell/    for spell check files
"
" See ':help vimfiles' for a description of the .vim file hierarchy

" Compatibility
set encoding=utf-8              " the encoding displayed
set fileencoding=utf-8          " the encoding written to file
set nocompatible                " disable vi compatibility mode, must be done first
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set mousefocus                  " window focus follows mouse
set mousehide                   " hide mouse pointer when characters are typed
set history=50                  " keep 50 lines of command line history
set viminfo='100,<1000,s100,h   " increase buffer size: https://stackoverflow.com/q/3676855

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"    set mouse=a
"endif

" Color and Style
if &t_Co > 2 || has("gui_running")
    syntax enable               " enable syntax highlighting
    set hlsearch                " highlight search results
    colorscheme monokai         " use color scheme in ~/.vim/colors
endif

" Window Splitting
" TODO: read https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally

" Display Line Numbers
"set number                      " display line numbers
set ruler                       " display cursor position
"set title                       " terminal title becomes filename being edited
"set titleold=""                 " return terminal title to normal value upon exiting

" Searching Criteria
set ignorecase                  " ignore case in search patterns
set smartcase                   " override ignorecase if search pattern has capital letters
set wildmode=longest,list       " list all matches
set showmatch                   " highlight matching parentheses/brackets
set incsearch                   " show matches while typing pattern

" Spell Checking
" Use ':set spell' and ':set nospell' to turn spell checking on/off
set spelllang=en_us

" Scrolling and Mouse Control
set scrolloff=10                " keep at least x lines above/below cursor if possible
set whichwrap+=<,>,[,],h,l      " <Left>, <Right>, h, and l wrap around line breaks
set nostartofline               " don't reset cursor to start of line when moving around

" Word Wrap
"set wrap                        " wrap visually instead of changing text in buffer
"set linebreak                   " only wrap at characters listed in the breakat option
"set nolist                      " list disables linebreaks

" Indentation
set autoindent                  " copy indentation from current line when starting new line
set copyindent                  " copy structure of indentation from previous line, e.g. comment symbols
set expandtab                   " <Tab> inserts softtabstop spaces. Use <Ctrl>-V <Tab> to get real tab
set tabstop=8                   " number of spaces that an existing <Tab> displays as
set softtabstop=4               " number of spaces to insert when the <Tab> key is pressed
set shiftwidth=4                " number of spaces to use for each auto-indent, e.g. >>, << commands

" Key Remaps
nmap <silent> ,/ :nohlsearch<CR>
nnoremap ; :
" https://github.com/microsoft/terminal/issues/5790#issuecomment-660532307
nnoremap v <c-v>

" Spack has a custom black configuration
" TODO - why doesn't this work in .vim/ftplugin/python.vim?
autocmd BufNewFile,BufRead ~/spack/*.py set colorcolumn=100

" Automatically add closing bracket and indent properly
"inoremap {<cr> {<cr>}<c-o>O<tab>
"inoremap [<cr> [<cr>]<c-o>O<tab>
"inoremap (<cr> (<cr>)<c-o>O<tab>

" Make searches always 'very magic'
"nnoremap / /\v
"cnoremap %s/ %s/\v

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type plugin and detection overrides in ~/.vim/
    filetype plugin on

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif

    " Whitespace Handling
    function! StripTrailingWhitespaces()
        " Save current cursor position
        let l = line(".")
        let c = col(".")
        " Save search history
        let s = @/
        " Delete trailing whitespaces
        %s/\s\+$//e
        " Return cursor to previous position
        call cursor(l, c)
        " Restore search history
        let @/ = s
    endfunction

    autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

    " Clear searches when opening file
    autocmd BufReadPre <buffer> :let @/ = ""

    " Add color column with project-specific line length
    function! ColorColumn()
        let path = expand('%:p:h')
        if path =~ expand("~/spack")
            setlocal colorcolumn=100
        else
            setlocal colorcolumn=89
        endif
    endfunction

    autocmd BufRead,BufNewFile *.py call ColorColumn()
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
