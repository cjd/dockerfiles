packloadall
set nocompatible " Disable vi compatibility
set backspace=indent,eol,start " Let me delete it all
set complete-=i " Disable completing keywords in included files (e.g., #include in C) - Speeds startup
set incsearch " Incremental search
set mouse=a " Enable mouse support
" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
" :diffupdate.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2 " Always show status line
set ruler " Show cursor position
set wildmenu " Enable autocompletion
set wildmode=longest:full,full " Enable autocompletion to longest common
set scrolloff=1 " Ensure there is always one line visible before/after current
set sidescroll=1 " Same for side scrolling
set sidescrolloff=2 " Same for side scrolling

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set showmatch
set ignorecase
set smartcase
set incsearch
set number
syntax on
set background=light
filetype plugin indent on
set guifont=Monospace
let spell_language_list = "british"
set foldmethod=marker
color desert
let g:airline_powerline_fonts = 1
let g:netrw_liststyle = 3 " treeview
let g:netrw_banner = 0 " Remove top banner
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" unicode symbols
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'


" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


command! Ka !kubectl apply -f %
command! Kd !kubectl delete -f %
