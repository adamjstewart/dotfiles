" Compatibility
set nocompatible                        " disable vi compatibility mode

" Color and Style
syntax enable                           " enable syntax highlighting
colorscheme monokai                     " use colorscheme in ~/.vim/colors

" Display Line Numbers
set number                              " display line numbers
set ruler                               " display cursor position

" Searching Criteria
set ignorecase                          " ignore case in search patterns
set smartcase                           " override ignorecase if search pattern has capital letters
set wildmode=longest,list
set showmatch
set hlsearch                            " highlight search results
set incsearch                           " show matches while typing pattern

" Scrolling and Mouse Control
set scrolloff=10                        " keep at least x lines above/below cursor if possible
set whichwrap+=<,>,[,],h,l              " <Left>, <Right>, h, and l wrap around line breaks
set nostartofline                       " don't reset cursor to start of line when moving around

" Word Wrap
set wrap                                " wrap visually instead of changing text in buffer
set linebreak                           " only wrap at characters listed in the breakat option
set nolist                              " list disables linebreaks
set textwidth=0
set wrapmargin=0

" Indentation
set autoindent                          " copy indentation from current line
set copyindent
set smarttab                            " backspace will delete shiftwidth worth of spaces
set expandtab                           " convert new tabs to spaces, use Ctrl-v-Tab to insert real tab
autocmd FileType make set noexpandtab   " don't convert tabs to spaces for Makefiles
set tabstop=4                           " number of spaces that <Tab> equals
set shiftwidth=4                        " number of spaces to use for each auto-indent
set softtabstop=4

" Key Remaps
nmap <silent> ,/ :nohlsearch<CR>
nnoremap ; :

" Make searches always 'very magic'
nnoremap / /\v
cnoremap %s/ %s/\v

" Whitespace Handling
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e                         " delete trailing whitspaces
    call cursor(l, c)                   " return cursor to previous position
endfunction

autocmd FileType perl,sh,python,vi autocmd BufWrite <buffer> :call StripTrailingWhitespaces()
autocmd BufReadPre <buffer> :let @/ = ""

