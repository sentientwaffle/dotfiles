call pathogen#infect()

" TODO
noremap <Space> @q

" set nocompatible
syntax on

" Hex editor
"   :%!xxd
" Revert
"   :%!xxd -r

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
set wildmode=longest:full " Better autocompletion
set title " show filename in window titlebar

" Extention matching
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8
autocmd FileType c,cpp setlocal noexpandtab shiftwidth=8 softtabstop=8

autocmd BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh set filetype=c

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

set cursorline

" Margin of 5 lines when navigating.
set scrolloff=5

" No startup message.
set shortmess+=I

" http://stackoverflow.com/questions/14036120/wonky-multibyte-character-display-in-vim-when-editing-over-ssh
set encoding=utf-8
set termencoding=utf-8

" http://superuser.com/questions/556915/how-to-let-vim-listchar-work-under-not-utf8-environment
scriptencoding utf-8
" Invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:_
set list

" 80 char margin
" highlight OverLength cterm=underline
" match OverLength /\%81v.\+/

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
nmap <C-\> <C-a>
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

" Open another tab of the file.
nmap <F3> :tabe %<CR>
" Open to current directory.
nmap <F4> :tabe .<CR>

" Escape for JavaScript.
nmap <F5> <S-v><S-v>:'<,'>!toutf16<CR>

" -----------------------------------------------------------------------------
" Auto
" -----------------------------------------------------------------------------
" Reload .vimrc when saved.
" autocmd bufwritepost .vimrc source $MYVIMRC

" Abbreviations
" JavaScript
autocmd FileType javascript abbreviate qfunc function() {<CR>}<ESC>k$F(i
autocmd FileType javascript abbreviate qif if () {<CR><TAB><CR><BS>}<ESC>kk$F)i
autocmd FileType javascript abbreviate qfor for (var i = 0, l =.length; i < l; i++) {<CR><TAB><CR><BS>}<ESC>kk$F.i
autocmd FileType javascript abbreviate she #!/usr/bin/env node
autocmd FileType javascript abbreviate pro prototype
autocmd FileType javascript abbreviate Ok Object.keys
autocmd FileType javascript abbreviate clog console.log

" Go
autocmd FileType go abbreviate qTest func Test(t *testing.T) {<CR><TAB><CR><BACKSPACE>}<ESC>kk$F(i
autocmd FileType go abbreviate qfunc func() {<CR><TAB><CR><BACKSPACE>}<ESC>kk$F(i

" au BufWritePost *.js echo system("jshint " . shellescape(expand('%:p')))


" -----------------------------------------------------------------------------
" Statusline
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Commands
" -----------------------------------------------------------------------------



