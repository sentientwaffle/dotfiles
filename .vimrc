call pathogen#infect('bundle/{}', '~/Bootstrap/src/vim/{}')

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
set listchars=tab:→\ ,trail:·,nbsp:␣,extends:⋯,precedes:⋯
set mouse=
set modelines=0
set nomodeline
set nrformats-=octal
set termencoding=utf-8
set thesaurus=$HOME/.cache/vim/thesaurus.txt " C-x C-t
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
  "set foldtext=FoldText()
  set nofoldenable
endif
if has('persistent_undo') && isdirectory($HOME . "/.cache/vim/undodir")
  set undodir=~/.cache/vim/undodir " Persistent undo
  set undofile
endif

" Location for '.netrwhist'.
let g:netrw_home=$HOME . "/.cache/vim"

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

" make n always search forward and N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
" make ; always "find" forward and , backward
"nnoremap <expr> ; getcharsearch().forward ? ';' : ','
"nnoremap <expr> , getcharsearch().forward ? ',' : ';'

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
" Exit normal mode.
inoremap jj <ESC>
" By default <C-u> erases the current line.
" If some text has been written (but not 'committed' by exiting to Normal mode) then the in-progress text is lost, and not recoverable by undo/redo. Which is inconvenient.
inoremap <C-u> <Nop>
vnoremap Y :'<,'>!copy<CR>

nnoremap <C-r> <C-r>:echoerr 'Use "U" to redo!'<CR>

nnoremap <C-d> :qall<CR>
nnoremap <TAB> gt
nnoremap <S-TAB> gT
" Increment/decrement.
nnoremap <C-\> <C-a>
nnoremap <C-]> <C-x>
" Follow help link.
nnoremap <C-p> <C-]>

" Clear search highlight.
nnoremap <silent> <C-l> :nohlsearch<CR>
" Execute default macro, and disable Ex mode
nnoremap Q @q
" Redo
nnoremap U <C-r>
" Yank to end of line.
nnoremap Y y$

" Navigation improvements.
" `onoremap` is for motions (operator-pending mappings).
" TODO use {,} for something else?
for mode in ['nnoremap', 'onoremap', 'vnoremap']
  execute mode . ' [ {'
  execute mode . ' ] }'
  execute mode . ' { ['
  execute mode . ' } ]'
endfor

" Disable Page Up & Page Down.
"nnoremap <PageUp>   <Nop>
"nnoremap <PageDown> <Nop>
"inoremap <PageUp>   <Nop>
"inoremap <PageDown> <Nop>
"vnoremap <PageUp>   <Nop>
"vnoremap <PageDown> <Nop>

" Leader
let mapleader = ' '
let maplocalleader = '\'

nnoremap <Leader> <Nop>
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>d :help digraphs<CR> :resize<CR>
" Get current syntax token stack.
nnoremap <Leader>s :call <SID>ToggleSynStack()<CR>
" View built-in vim syntax files.
nnoremap <Leader>S :tabe $VIMRUNTIME/syntax/<CR>
" Open another tab of the file.
nnoremap <Leader>t :tabe %<CR>
" Open to current directory.
nnoremap <Leader>T :tabe .<CR>
nnoremap <Leader>w :call <SID>ToggleWrap()<CR>

" See `:help press-enter`.
nnoremap <Leader>f :call <SID>FzyOpen('_fzy_find', ':tabedit')<CR>
function! <SID>FzyOpen(choice_command, vim_command)
  try
    let output = system(a:choice_command)
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    execute a:vim_command . ' ' . output
  endif
endfunction

"function! FoldText()
"  let l:line = getline(v:foldstart)
"  let l:count = v:foldend - v:foldstart + 1
"  let l:info = ' ' . l:count . ' lines'
"  let l:gutter_width = getwinvar(0, '&number') * getwinvar(0, '&numberwidth')
"    \ + getwinvar(0, '&foldcolumn')
"  let l:snip_width = winwidth(0) - l:gutter_width - 1 - strlen(l:info)
"  let l:snip = strpart(l:line, 0, l:snip_width)
"  let l:pad = repeat(' ', l:snip_width - strlen(l:line))
"  return l:snip . l:pad . l:info
"endfunction

function! <SID>ToggleSynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! <SID>SystemOperator(command, mode, is_visual)
  if a:is_visual
    " Invoked from Visual mode.
    execute "'<,'>" . a:command
  else
    " Invoked from Normal mode.
    execute "'[,']" . a:command
  endif
endfunction

" Custom operator.
" Insert spaces to align motion/selected lines over the given character.
function! <SID>Align(mode, is_visual)
  let l:separator = nr2char(getchar())
  let l:command = '!column -t -L'
    \ . ' -s ' . shellescape(l:separator)
    \ . ' -o ' . shellescape(l:separator)
  call <SID>SystemOperator(l:command, a:mode, a:is_visual)
endfunction

" TODO support reformatting comments (i.e. with `//` prefix)
function! <SID>Format(mode, is_visual)
  let l:command = '!fmt -80 --goal=80'
  call <SID>SystemOperator(l:command, a:mode, a:is_visual)
endfunction

" See `:help 'map-operator'`.
nnoremap <silent> = :set opfunc=<SID>Align<CR>g@
vnoremap <silent> = :<C-U>call <SID>Align(visualmode(), 1)<CR>
nnoremap <silent> + :set opfunc=<SID>Format<CR>g@
vnoremap <silent> + :<C-U>call <SID>Format(visualmode(), 1)<CR>

" -----------------------------------------------------------------------------
" Text wrapping
" -----------------------------------------------------------------------------

function! <SID>ToggleWrap()
  if &wrap
    call <SID>WrapOff()
    echo 'Wrap OFF'
  else
    call <SID>WrapOn()
    echo 'Wrap ON'
  endif
endfunction

function! <SID>WrapOn()
  set wrap
  set linebreak
  set breakindent
  set showbreak=\|\ 
endfunction

function! <SID>WrapOff()
  set nowrap
  set nolinebreak
  set nobreakindent
  set showbreak=
endfunction

call <SID>WrapOn()

function! <SID>NavigateWrapped()
  " Sane wrapped-text navigation.
  for mode in ['nnoremap', 'vnoremap']
    execute mode . ' <buffer> <silent> k      gk'
    execute mode . ' <buffer> <silent> j      gj'
    execute mode . ' <buffer> <silent> 0      g0'
    execute mode . ' <buffer> <silent> $      g$'
    execute mode . ' <buffer> <silent> <Home> g0'
    execute mode . ' <buffer> <silent> <End>  g$'
  endfor
endfunction

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
augroup FTOptions
  autocmd!
  " ftdetect
  autocmd BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag set filetype=glsl

  autocmd BufNewFile,BufRead go.mod            set filetype=gomod
  autocmd BufNewFile,BufRead go.sum            set filetype=text
  autocmd BufNewFile,BufRead *.graphql         set filetype=graphql
  autocmd BufNewFile,BufRead *.gyp,*.pod       set filetype=json
  autocmd BufNewFile,BufRead *.h               set filetype=c
  autocmd BufNewFile,BufRead *.i               set filetype=i
  autocmd BufNewFile,BufRead *.k               set filetype=k
  autocmd BufNewFile,BufRead *.tf              set filetype=terraform
  autocmd BufNewFile,BufRead *.ts,*.tsx        set filetype=typescript
  autocmd BufNewFile,BufRead *.toml,Cargo.lock set filetype=toml
  autocmd BufNewFile,BufRead ~/Bootstrap/data/mux/*.txt    set filetype=mux
  autocmd BufNewFile,BufRead ~/Bootstrap/data/bmux/*.txt   set filetype=feeds
  autocmd BufNewFile,BufRead ~/Bootstrap/data/feeds.txt    set filetype=feeds
  autocmd BufNewFile,BufRead ~/Bootstrap/data/schedule.txt set filetype=schedule

  " Folding
  autocmd FileType json,terraform,yaml setlocal foldmethod=indent

  " Indentation
  autocmd FileType python,rust                    setlocal   expandtab shiftwidth=4 softtabstop=4
  autocmd FileType c,cpp,go,gomod,make            setlocal noexpandtab shiftwidth=8 softtabstop=8
  autocmd FileType bash,sh,gitconfig,html,css,lua setlocal noexpandtab shiftwidth=8 softtabstop=8

  " Spellchecking
  autocmd FileType mail,gitcommit,markdown,text setlocal spell

  " Navigation
  autocmd FileType markdown call <SID>NavigateWrapped()

  " Help (shift-K)
  autocmd FileType vim setlocal keywordprg=:help
  autocmd FileType rust,typescript setlocal keywordprg=git\ grep

  autocmd FileType journal runtime! ftplugin/journal.vim
  autocmd FileType disasm  runtime! ftplugin/disasm.vim

  " Selectively disable undofile.
  " `pass` creates temporary files in /dev/shm/, so ignore those as well.
  autocmd BufWritePre /tmp/*,/dev/* setlocal noundofile
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
set statusline+=\ │\ %-(%l:%v%) " (line:column)
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
