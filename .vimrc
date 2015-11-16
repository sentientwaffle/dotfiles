call pathogen#infect()

" Hex editor
"   :%!xxd
" Revert
"   :%!xxd -r

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
syntax on

set backspace=indent,eol,start " Backspace over anything
set nofoldenable " No folding
set mouse=a
set history=150

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent " copy indentation from current line to new line
set nowrap
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2
set tabstop=8 " number of visual spaces per tab
set expandtab " tabs are spaces

set wildmenu " command-line completion
set wildmode=longest:full " Better autocompletion
set title " show filename in window titlebar

" -----------------------------------------------------------------------------
" UI
" ------------------------------------------------------------------------------
set ruler " show cursor position
set number " line numbers
set fillchars=vert:│ " vsplit character

" Search
set hlsearch " hightlight searches
set incsearch " search as characters are entered
set ignorecase " ignore search case
set smartcase " strict case when upper in search term

" Theming
set t_Co=256 " 256 colors
colorscheme custom

set cursorline " highlight current line
set scrolloff=2 " Line margin when navigating.
set shortmess+=I " No startup message.

" http://stackoverflow.com/questions/14036120/wonky-multibyte-character-display-in-vim-when-editing-over-ssh
set encoding=utf-8
set termencoding=utf-8

" http://superuser.com/questions/556915/how-to-let-vim-listchar-work-under-not-utf8-environment
scriptencoding utf-8
" Invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:_
set list

" -----------------------------------------------------------------------------
" Backups
" -----------------------------------------------------------------------------
set noswapfile
set nobackup
set nowb

" -----------------------------------------------------------------------------
" Keybindings
" -----------------------------------------------------------------------------

inoremap <Nul> <C-p>

nnoremap <TAB> gt
nnoremap <S-TAB> gT
" Increment.
nnoremap <C-\> <C-a>
" Clear search highlight.
nnoremap <C-l> :noh<CR>

" Disable Page Up & Page Down.
nnoremap <PageUp>   <Nop>
nnoremap <PageDown> <Nop>
inoremap <PageUp>   <Nop>
inoremap <PageDown> <Nop>
vnoremap <PageUp>   <Nop>
vnoremap <PageDown> <Nop>

" Execute default macro, and disable Ex mode
nnoremap Q @q

" Leader
let mapleader = " "

nnoremap <Leader>  <Nop>
" Get current syntax token stack.
nnoremap <Leader>s :call <SID>SynStack()<CR>
" View built-in vim syntax files.
nnoremap <Leader>S :tabe $VIMRUNTIME/syntax/<CR>
" Open another tab of the file.
nnoremap <Leader>t :tabe %<CR>
" Open to current directory.
nnoremap <Leader>T :tabe .<CR>
" Toggle paste mode.
nnoremap <Leader>p :set paste!<CR>

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
" Reload .vimrc when saved.
" autocmd bufwritepost .vimrc source $MYVIMRC
" TODO: autogroups

" ftdetect
autocmd BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh set filetype=c
autocmd BufNewFile,BufRead *.gyp                                         set filetype=json

" Indentation
autocmd FileType python,rust                setlocal   expandtab shiftwidth=4 softtabstop=4
autocmd FileType go,make,c,cpp,sh,gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8

" Spellchecking
autocmd FileType mail,gitcommit setlocal spell

" au BufWritePost *.js echo system("jshint " . shellescape(expand('%:p')))

" Help (shift-K)
autocmd FileType vim setlocal keywordprg=:help

" -----------------------------------------------------------------------------
" Abbreviations
" -----------------------------------------------------------------------------
" JavaScript
autocmd FileType javascript iabbrev pro prototype

" Go
autocmd FileType go iabbrev qTest func Test(t *testing.T) {<CR><TAB><CR><BACKSPACE>}<ESC>kk$F(i
autocmd FileType go iabbrev qfunc func() {<CR><TAB><CR><BACKSPACE>}<ESC>kk$F(i

" -----------------------------------------------------------------------------
" Statusline
" -----------------------------------------------------------------------------

set laststatus=2 " Always show statusbar

" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%<
set statusline+=\ %.99f " filename
set statusline+=\ %h " [help]
set statusline+=%w " [Preview]
set statusline+=%m " [+] (modified)
set statusline+=%r " [RO] (readonly)
set statusline+=%{&paste?'[paste]':''} " [paste]
"set statusline+=%#ErrorMsg#%*

set statusline+=%= " left/right split
set statusline+=%{&fileformat} " unix
set statusline+=\ │\ %{&termencoding} " utf-8
set statusline+=\ │\ %{strlen(&ft)?&ft:'none'} " file type, e.g.: vim
set statusline+=\ │\ %3.p%% " 12%
set statusline+=\ │\ %-(%l,%v%) " (line,column)
set statusline+=\ 

" -----------------------------------------------------------------------------
" Tabline
" -----------------------------------------------------------------------------

set tabpagemax=20 " maximum tabs opened by `-p` command-line argument
set showtabline=2 " always show tab line (even for 1 file)

" -----------------------------------------------------------------------------
" Commands
" -----------------------------------------------------------------------------

" Save file as sudo.
command W w !sudo tee % >/dev/null

" Reformat XML
command PrettyXML %!xmllint --format -

" Escape for JavaScript.
command -range ToUTF16 <line1>,<line2>!toutf16
