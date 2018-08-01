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
set nocompatible                " disable vi compatibility mode, must be done first
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set mousefocus                  " window focus follows mouse
set mousehide                   " hide mouse pointer when characters are typed
set history=50                  " keep 50 lines of command line history

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

    " Read a skeleton (template) file when opening a new file
    autocmd BufNewFile *.pbs 0r ~/.vim/skeletons/skeleton.pbs
    autocmd BufNewFile *.pl  0r ~/.vim/skeletons/skeleton.pl
    autocmd BufNewFile *.py  0r ~/.vim/skeletons/skeleton.py
    autocmd BufNewFile *.rb  0r ~/.vim/skeletons/skeleton.rb
    autocmd BufNewFile *.sh  0r ~/.vim/skeletons/skeleton.sh

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
    
    " Clear searches when opening file
    autocmd BufReadPre <buffer> :let @/ = ""
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
