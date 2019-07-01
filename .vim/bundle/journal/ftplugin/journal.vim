if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" TODO file locking (readonly & nomodifiable)
" TODO open|copy href
" Initialization
if !exists('w:history')
  let w:history = ['Index']
endif

setlocal filetype=journal
setlocal wrap
setlocal linebreak " word breaking
setlocal breakindent " indent wrapped lines
setlocal showbreak=\|\ 
setlocal omnifunc=journal#CompleteDocument " C-x C-o
setlocal spell

" ------------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------------

" Sane wrapped-text navigation.
for mode in ['nnoremap', 'vnoremap']
  execute mode . ' <buffer> <silent> k      gk'
  execute mode . ' <buffer> <silent> j      gj'
  execute mode . ' <buffer> <silent> 0      g0'
  execute mode . ' <buffer> <silent> $      g$'
  execute mode . ' <buffer> <silent> <Home> g0'
  execute mode . ' <buffer> <silent> <End>  g$'
endfor

" Link navigation
nnoremap <buffer> <silent> <CR> :call journal#GoToCurrentDocument()<CR>
nnoremap <buffer> <silent> <BS> :call journal#GoBack()<CR>

" Section navigation
" (see http://learnvimscriptthehardway.stevelosh.com/chapters/51.html)
nnoremap <buffer> <silent> [[ :call journal#FindLink('?')<CR>
nnoremap <buffer> <silent> ]] :call journal#FindLink('/')<CR>
vnoremap <buffer> <silent> [[ <Nop>
vnoremap <buffer> <silent> ]] <Nop>

" Document management
nnoremap <buffer> <LocalLeader>R :call journal#RenameCurrentDocument()<CR>
nnoremap <buffer> <LocalLeader>D :call journal#DeleteCurrentDocument()<CR>
