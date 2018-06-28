if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

syn region muxString    matchgroup=muxCommand    start='^title'                    end='$' oneline
syn region muxNumber    matchgroup=muxCommand    start='^\(hsplit\|vsplit\|pane\)' end='$' oneline
syn region muxLayoutCmd matchgroup=muxCommand    start='^layout '                  end='$' oneline contains=muxLayout
syn region muxString    matchgroup=muxSubCommand start='^  \(cd\|run\) '           end='$' oneline

" Can't use 'syn-keyword' because the option iskeyword doesn't include '-'.
syn match muxLayout contained "\(even-horizontal\|even-vertical\|main-horizontal\|main-vertical\|tiled\)$"

hi def link muxCommand    Keyword
hi def link muxSubCommand Type
hi def link muxString     String
hi def link muxNumber     Number
hi def link muxLayout     Number

let b:current_syntax = 'mux'
