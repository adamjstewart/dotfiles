" Compatibility
set nocompatible                        " disable vi compatibility mode
set backspace=indent,eol,start          " if unset, vi compatible backspacing is used
set mousefocus                          " window focus follows mouse
set mousehide                           " hide mouse pointer when characters are typed

" Color and Style
syntax enable                           " enable syntax highlighting
colorscheme monokai                     " use colorscheme in ~/.vim/colors

" Window Splitting
" TODO: read https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally

" Display Line Numbers
"set number                              " display line numbers
set ruler                               " display cursor position
set title                               " terminal title becomes filename being edited
set titleold=""                         " return terminal title to normal value upon exiting

" Searching Criteria
set ignorecase                          " ignore case in search patterns
set smartcase                           " override ignorecase if search pattern has capital letters
set wildmode=longest,list               " list all matches
set showmatch                           " highlight matching parentheses/brackets
set hlsearch                            " highlight search results
set incsearch                           " show matches while typing pattern

" Spell Checking
" Use ':set spell' and ':set nospell' to turn spell checking on/off
set spelllang=en_us

" Scrolling and Mouse Control
set scrolloff=10                        " keep at least x lines above/below cursor if possible
set whichwrap+=<,>,[,],h,l              " <Left>, <Right>, h, and l wrap around line breaks
set nostartofline                       " don't reset cursor to start of line when moving around

" Word Wrap
"set wrap                                " wrap visually instead of changing text in buffer
"set linebreak                           " only wrap at characters listed in the breakat option
"set nolist                              " list disables linebreaks

" Indentation
"set autoindent                          " copy indentation from current line when starting new line
set copyindent                          " copy structure of indentation from previous line, e.g. comment symbols
set expandtab                           " <Tab> inserts softtabstop spaces. Use <Ctrl>-V <Tab> to get real tab
autocmd FileType make set noexpandtab   " don't convert tabs to spaces for Makefiles
set tabstop=4                           " number of spaces that <Tab> equals
set shiftwidth=4                        " number of spaces to use for each auto-indent, e.g. >>, << commands
set softtabstop=4

autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2

" Key Remaps
nmap <silent> ,/ :nohlsearch<CR>
nnoremap ; :

" Make searches always 'very magic'
"nnoremap / /\v
"cnoremap %s/ %s/\v

" Jump to last known position in a file just after opening it
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Whitespace Handling
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e                         " delete trailing whitspaces
    call cursor(l, c)                   " return cursor to previous position
endfunction
autocmd FileType perl,sh,python,ruby,vi autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Clear searches when opening file
autocmd BufReadPre <buffer> :let @/ = ""

" Use JavaScript syntax highlighting for JSON files
autocmd BufRead,BufNewFile *.json,*.sublime-settings setfiletype javascript

" Highlight column 80 for Python files
autocmd FileType python set colorcolumn=80
