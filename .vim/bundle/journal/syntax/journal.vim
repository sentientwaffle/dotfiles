if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

" ------------------------------------------------------------------------------
" Matching
" ------------------------------------------------------------------------------

syn region journalMetadataValue matchgroup=journalMetadataKey start="^ *#\w\+" end="$" oneline
syn region journalTable         matchgroup=journalTableColumn start="^ *|" end="|$" oneline contains=journalTableColumn
syn match  journalTableColumn "|" contained

syn region journalURLHref  matchgroup=journalURLDelimiter start="<"  end=">"             oneline contains=@NoSpell
syn region journalURLTitle matchgroup=journalURLDelimiter start="\[" end="\]\((.*)\)\@=" oneline nextgroup=journalURLHref
syn region journalURLHref  matchgroup=journalURLDelimiter start="(\([^)]*\)\@=" end=")"  oneline contained contains=@NoSpell
"syn match  journalLink     '<[[:alnum:]_.]\+>'

syn region journalBold   start="\*[^ ]" end="\*" oneline
syn region journalItalic start="_[^ ]"  end="_"  oneline
syn region journalCode   start="`"      end="`"  oneline contains=@NoSpell

syn region journalHeader     start="^ *= " end="$" oneline
syn region journalCode       start="^ *` " end="$" oneline contains=@NoSpell
syn region journalBlockQuote start="^ *> " end="$" oneline
syn match  journalUList "^ *\* "
syn match  journalOList "^ *# "

" ------------------------------------------------------------------------------
" Groups
" ------------------------------------------------------------------------------

hi def link journalMetadataKey   PreProc
hi def link journalMetadataValue PreProc
hi def link journalTable         String
hi def link journalTableColumn   Delimiter

hi def link journalHeader        Keyword
hi def link journalCode          Comment
hi def link journalBlockQuote    Comment
hi def link journalUList         Keyword
hi def link journalOList         Keyword

"hi def link journalLink          String
hi def link journalURLDelimiter  Delimiter
hi def link journalURLTitle      String
hi def link journalURLHref       Float

let b:current_syntax = 'journal'
