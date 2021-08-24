if exists('g:loaded_journal')
  finish
endif
let g:loaded_journal = 1
let s:link_pattern = '\(\l\+\.\)\=[a-zA-Z0-9_]\+'

" ------------------------------------------------------------------------------
" Commands
" ------------------------------------------------------------------------------

function journal#GoToCurrentDocument()
  let word = expand('<cWORD>')
  if !s:isLinkURL(word)
    echomsg 'No link found: ' . word
    return
  endif
  call s:gotoLink(word[1:-2])
endfunction

function journal#GoBack()
  if len(w:history) == 1
    echomsg "You can't go back"
    return
  endif
  call remove(w:history, -1)
  call s:gotoLink(w:history[-1])
endfunction

"function journal#FindLink(direction)
"  if !search('<' . s:link_pattern . '>', a:direction ==# '?' ? 'b' : '')
"    echomsg 'No links found'
"  endif
"endfunction

function journal#CompleteDocument(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\m[[:alnum:]\.]'
      let start -= 1
    endwhile
    return start
  endif

  if a:base ==# ''
    return s:listDocuments()
  else
    return filter(s:listDocuments(), 'v:val =~ ''\V\^' . a:base . "'")
  endif
endfunction

function journal#RenameCurrentDocument()
  let dstLink = input('Enter document name: ')
  if !s:isLink(dstLink)
    echomsg 'Not a valid link: ' . dstLink
    return
  endif
  let srcFile = expand('%:p')
  let srcLink = s:fileToLink(srcFile)
  let dstFile = s:linkToFile(dstLink)
  if filereadable(dstFile)
    echomsg 'A document by that name already exists'
    return
  endif
  update
  call rename(srcFile, dstFile)
  call s:renameLink(srcLink, dstLink)
  call s:openLink(dstLink)
endfunction

function journal#DeleteCurrentDocument()
  let linkFile = expand('%:p')
  let link = s:fileToLink(linkFile)
  if input('Delete <' . link . '>? (yes|no) ') == 'yes'
    call delete(linkFile)
    call journal#GoBack()
  else
    " Clear the input() message.
    redraw!
  endif
endfunction

" ------------------------------------------------------------------------------
" Navigation helpers
" ------------------------------------------------------------------------------

function s:gotoLink(link)
  if w:history[-1] !=# a:link
    call add(w:history, a:link)
  endif
  call s:openLink(a:link)
endfunction

function s:openLink(link)
  update
  let file = s:linkToFile(a:link)
  let dir = s:linkDirectory(a:link)
  " Open existing buffer
  if bufexists(file)
    execute 'buffer ' . bufnr(file)
    return
  endif
  if !isdirectory(dir)
    call mkdir(dir)
  endif
  execute 'edit ' . fnameescape(file)
endfunction

function s:listDocuments()
  let dir = $JOURNAL_DIR
  let ext = '.jtxt'
  let files = glob(dir . '/**/*' . ext, 0, 1)
  let documents = []
  for file in files
    let document = file[len(dir) + 1 : -len(ext) - 1]
    call add(documents, substitute(document, '/', '.', ''))
  endfor
  return documents
endfunction

function s:renameLink(srcLink, dstLink)
  call system('find ' . shellescape($JOURNAL_DIR)
    \ . ' -name "*.jtxt"'
    \ . ' -type f'
    \ . ' -exec awk -i inplace'
    \ .   " 'm = /^ *[>`|] |^ *#[^ ]/ {"
    \ .     "print $0"
    \ .   "} !m {"
    \ .     "gsub(\"<" . escape(a:srcLink, '.') . ">\", \"<" . a:dstLink. ">\");"
    \ .     "print $0"
    \ .   "}'"
    \ . ' {} \;')
endfunction

" ------------------------------------------------------------------------------
" Link helpers
" ------------------------------------------------------------------------------

function s:isLink(link)
  return a:link =~ s:link_pattern
endfunction

function s:isLinkURL(link)
  return a:link =~ '<' . s:link_pattern . '>'
endfunction

function s:linkDirectory(link)
  let parts = s:linkParts(a:link)
  let dir = $JOURNAL_DIR
  if len(parts) == 2
    return dir . '/' . parts[0]
  endif
  return dir
endfunction

function s:linkToFile(link)
  return s:linkDirectory(a:link) . '/' . s:linkParts(a:link)[-1] . '.jtxt'
endfunction

function s:fileToLink(file)
  let dir = $JOURNAL_DIR
  let ext = '.jtxt'
  return substitute(a:file[len(dir) + 1 : -len(ext) - 1], '/', '.', '')
endfunction

function s:linkParts(link)
  return split(a:link, '\.')
endfunction

" ------------------------------------------------------------------------------
" Flashcards
" ------------------------------------------------------------------------------

function journal#InsertFlashcardId()
  call append(line('.'), strftime("/.id %s"))
endfunction
