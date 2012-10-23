call pathogen#infect()

" set nocompatible
syntax on

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
" Backspace over anything
set backspace=indent,eol,start

" No folding
set nofoldenable

" -----------------------------------------------------------------------------
" Mouse
" -----------------------------------------------------------------------------
set mouse=a

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent
" set smartindent
set nowrap
set softtabstop=2
set shiftwidth=2
set tabstop=8
set expandtab

set wildmenu " command-line completion
set title " show flename in window titlebar

" Extention matching
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8

" Spellchecking
autocmd FileType mail setlocal spell
autocmd FileType gitcommit setlocal spell

" -----------------------------------------------------------------------------
" UI
" ------------------------------------------------------------------------------
set ruler " show cursor position
set number " line numbers
" set ch=2

" Search
set hlsearch " hightlight searches
set ignorecase " ignore search case
set incsearch " increment
set smartcase " strict case when upper in search term

" Theming
set background=dark
let g:solarized_termcolors=256
set t_Co=256
colorscheme solarized

" Invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:_
set list

" 80 char margin
highlight OverLength cterm=underline
match OverLength /\%81v.\+/

" Statusbar
set laststatus=2

" -----------------------------------------------------------------------------
" Backups
" -----------------------------------------------------------------------------
set noswapfile
set nobackup
set nowb

" -----------------------------------------------------------------------------
" Keybindings
" -----------------------------------------------------------------------------
imap <Nul> <C-p>

nmap <TAB> gt
nmap <S-TAB> gT
" Increment.
nmap <C-]> <C-a>
" Clear search highlight.
nmap <C-l> :noh<CR>

" Disable Page Up & Page Down.
nmap <PageUp> <Nop>
nmap <PageDown> <Nop>
imap <PageUp> <Nop>
imap <PageDown> <Nop>
vmap <PageUp> <Nop>
vmap <PageDown> <Nop>

" Toggle paste mode.
nmap <F2> :set nopaste!<CR>

" -----------------------------------------------------------------------------
" Auto
" -----------------------------------------------------------------------------
" Reload .vimrc when saved.
" autocmd bufwritepost .vimrc source $MYVIMRC


" -----------------------------------------------------------------------------
" Statusline
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Commands
" -----------------------------------------------------------------------------



