if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

syn region muxString matchgroup=muxCommand    start='^title'                    end='$' oneline
syn region muxNumber matchgroup=muxCommand    start='^\(hsplit\|vsplit\|pane\)' end='$' oneline
syn region muxString matchgroup=muxSubCommand start='^  \(cd\|run\) '           end='$' oneline

hi def link muxCommand    Keyword
hi def link muxSubCommand Type
hi def link muxString     String
hi def link muxNumber     Number

let b:current_syntax = 'journal'
