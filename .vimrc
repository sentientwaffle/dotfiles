call pathogen#infect()

" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" http://superuser.com/questions/556915/how-to-let-vim-listchar-work-under-not-utf8-environment
scriptencoding utf-8

set backspace=indent,eol,start " Backspace over anything
" http://stackoverflow.com/questions/14036120/wonky-multibyte-character-display-in-vim-when-editing-over-ssh
set encoding=utf-8
set history=500
set lazyredraw " Faster macro repetition.
set list
set listchars=tab:▸\ ,trail:·,nbsp:_ " Invisible characters
set mouse=a
set modelines=0
set nomodeline
set nrformats-=octal
set termencoding=utf-8
set title " show filename in window titlebar
set wildmenu " command-line completion
set wildmode=longest:full " Better autocompletion

" Backups
set nobackup
set noswapfile
set nowb

if has('folding')
  set foldignore=
  set foldopen-=block
  set foldtext=FoldText()
  set nofoldenable
endif
if has('persistent_undo') && isdirectory($HOME . "/.vim/undodir")
  set undodir=~/.vim/undodir " Persistent undo
  set undofile
endif

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent " copy indentation from current line to new line
set expandtab " tabs are spaces
set nowrap
set shiftwidth=2 " number of spaces for each autoindent step, `<<`, and `>>`.
set softtabstop=2 " number of spaces in tab when editing
set tabstop=8 " number of visual spaces per tab

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
set display+=lastline
set scrolloff=2 " Line margin when navigating.
set shortmess+=I " No startup message.

" -----------------------------------------------------------------------------
" Keybindings
" -----------------------------------------------------------------------------

inoremap <Nul> <C-p>

nnoremap <C-d> :qall<CR>
nnoremap <TAB> gt
nnoremap <S-TAB> gT
" Increment.
nnoremap <C-\> <C-a>
" Clear search highlight.
nnoremap <silent> <C-l> :nohlsearch<CR>
" Execute default macro, and disable Ex mode
nnoremap Q @q
" Yank to end of line.
nnoremap Y y$

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
nnoremap <Leader>p :set paste!<CR>
" Get current syntax token stack.
nnoremap <Leader>s :call <SID>ToggleSynStack()<CR>
" View built-in vim syntax files.
nnoremap <Leader>S :tabe $VIMRUNTIME/syntax/<CR>
" Open another tab of the file.
nnoremap <Leader>t :tabe %<CR>
" Open to current directory.
nnoremap <Leader>T :tabe .<CR>
nnoremap <Leader>x :call <SID>ToggleHex()<CR>
nnoremap <Leader>w :call <SID>ToggleWrap()<CR>

function! FoldText()
  let l:line = getline(v:foldstart)
  let l:count = v:foldend - v:foldstart + 1
  let l:info = ' ' . l:count . ' lines'
  let l:gutter_width = getwinvar(0, '&number') * getwinvar(0, '&numberwidth')
    \ + getwinvar(0, '&foldcolumn')
  let l:snip_width = winwidth(0) - l:gutter_width - 1 - strlen(l:info)
  let l:snip = strpart(l:line, 0, l:snip_width)
  let l:pad = repeat(' ', l:snip_width - strlen(l:line))
  return l:snip . l:pad . l:info
endfunction

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
  if &wrap
    echo 'Wrap ON'
  else
    echo 'Wrap OFF'
  endif
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
  autocmd BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh set filetype=glsl

  autocmd BufNewFile,BufRead go.mod            set filetype=gomod
  autocmd BufNewFile,BufRead go.sum            set filetype=text
  autocmd BufNewFile,BufRead *.graphql         set filetype=graphql
  autocmd BufNewFile,BufRead *.gyp,*.pod       set filetype=json
  autocmd BufNewFile,BufRead *.tf              set filetype=terraform
  autocmd BufNewFile,BufRead *.ts,*.tsx        set filetype=typescript
  autocmd BufNewFile,BufRead *.toml,Cargo.lock set filetype=toml
  autocmd BufNewFile,BufRead ~/Code/mux/*.txt  set filetype=mux nospell
  autocmd BufNewFile,BufRead ~/Code/bmux/*.txt set nospell

  " Folding
  autocmd FileType json,terraform,yaml setlocal foldmethod=indent

  " Indentation
  autocmd FileType python,rust                      setlocal   expandtab shiftwidth=4 softtabstop=4
  autocmd FileType go,gomod,make,c,cpp,sh,gitconfig setlocal noexpandtab shiftwidth=8 softtabstop=8

  " Spellchecking
  autocmd FileType mail,gitcommit,markdown,text setlocal spell

  " Help (shift-K)
  autocmd FileType vim setlocal keywordprg=:help

  autocmd FileType journal runtime! ftplugin/journal.vim
  autocmd FileType disasm  runtime! ftplugin/disasm.vim

  " Disable undofile.
  " `pass` creates temporary files in /dev/shm/, so ignore those as well.
  autocmd BufWritePre /tmp/*,/dev/* setlocal noundofile
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

set showtabline=2 " always show tab line (even for 1 file)
set tabpagemax=40 " maximum tabs opened by `-p` command-line argument

" -----------------------------------------------------------------------------
" Commands
" -----------------------------------------------------------------------------

" Save file as sudo.
command W w !sudo tee % >/dev/null

" Reformat XML
command PrettyXML %!xmllint --format -

" Escape for JavaScript.
command -range ToUTF16 <line1>,<line2>!toutf16

" -----------------------------------------------------------------------------
" Bracketed paste
" -----------------------------------------------------------------------------

" https://github.com/ConradIrwin/vim-bracketed-paste/blob/c4c639f3cacd1b874ed6f5f196fac772e089c932/plugin/bracketed-paste.vim
" https://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" https://github.com/tmux/tmux/commit/f4fdddc9306886e3ab5257f40003f6db83ac926b
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode

" TODO don't redraw screen during paste?

if &term =~ '^tmux' || &term =~ 'xterm' || &term =~ 'screen'
  let &t_ti .= "\<Esc>[?2004h"
  let &t_te = "\e[?2004l" . &t_te

  function! <SID>XTermPasteBegin(ret)
    set pastetoggle=<f29>
    set paste
    return a:ret
  endfunction

  execute "set <f28>=\<Esc>[200~"
  execute "set <f29>=\<Esc>[201~"
  map  <expr> <f28> <SID>XTermPasteBegin("i")
  imap <expr> <f28> <SID>XTermPasteBegin("")
  vmap <expr> <f28> <SID>XTermPasteBegin("c")
  cmap <f28> <nop>
  cmap <f29> <nop>
endif
