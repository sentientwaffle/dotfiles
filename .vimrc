call pathogen#infect()

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
syntax on

set backspace=indent,eol,start " Backspace over anything
set nofoldenable " No folding
set mouse=a
set history=150

set wildmenu " command-line completion
set wildmode=longest:full " Better autocompletion
set title " show filename in window titlebar

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent " copy indentation from current line to new line
set nowrap
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2 " number of spaces for each autoindent step, `<<`, and `>>`.
set tabstop=8 " number of visual spaces per tab
set expandtab " tabs are spaces

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
" Execute default macro, and disable Ex mode
nnoremap Q @q

" Disable Page Up & Page Down.
nnoremap <PageUp>   <Nop>
nnoremap <PageDown> <Nop>
inoremap <PageUp>   <Nop>
inoremap <PageDown> <Nop>
vnoremap <PageUp>   <Nop>
vnoremap <PageDown> <Nop>

" Leader
let mapleader = ' '
let maplocalleader = '\'

nnoremap <Leader>  <Nop>
" Get current syntax token stack.
nnoremap <Leader>s :call <SID>ToggleSynStack()<CR>
" View built-in vim syntax files.
nnoremap <Leader>S :tabe $VIMRUNTIME/syntax/<CR>
" Open another tab of the file.
nnoremap <Leader>t :tabe %<CR>
" Open to current directory.
nnoremap <Leader>T :tabe .<CR>
" Toggle paste mode.
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>x :call <SID>ToggleHex()<CR>
nnoremap <Leader>w :call <SID>ToggleWrap()<CR>

function! <SID>ToggleSynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! <SID>ToggleWrap()
  set wrap!
  set linebreak!
  set breakindent!
  set showbreak=\|\ 
endfunction

function! <SID>ToggleHex()
  if exists('b:is_hex')
    let &filetype = b:is_hex
    unlet b:is_hex
    %!xxd -r
  else
    let b:is_hex = &filetype
    let &filetype = 'xxd'
    %!xxd
  endif
endfunction

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------

augroup FTOptions
  autocmd!
  " ftdetect
  autocmd BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh set filetype=c
  autocmd BufNewFile,BufRead *.gyp                                         set filetype=json
  autocmd BufNewFile,BufRead *.ts                                          set filetype=javascript
  autocmd BufNewFile,BufRead ~/Code/mux/*.txt                              set filetype=mux

  " Indentation
  autocmd FileType python,rust                setlocal   expandtab shiftwidth=4 softtabstop=4
  autocmd FileType go,make,c,cpp,sh,gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8

  " Spellchecking
  autocmd FileType mail,gitcommit setlocal spell

  " Help (shift-K)
  autocmd FileType vim setlocal keywordprg=:help

  autocmd FileType journal runtime! ftplugin/journal.vim
  autocmd FileType disasm  runtime! ftplugin/disasm.vim
augroup END

augroup FTAbbreviations
  autocmd!
  " JavaScript
  autocmd FileType javascript inoreabbrev pro prototype
  " Go
  "autocmd FileType go inoreabbrev qTest func Test(t *testing.T) {<CR><TAB><CR><BACKSPACE>}<ESC>kk$F(i
augroup END

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
