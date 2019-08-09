if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

syn region muxComment   matchgroup=muxComment    start='#'                         end='$' oneline
syn region muxString    matchgroup=muxCommand    start='^title'                    end='$' oneline
syn region muxSplitCmd  matchgroup=muxCommand    start='^\(hsplit\|vsplit\|pane\)' end='$' oneline contains=muxSplitValue
syn region muxLayoutCmd matchgroup=muxCommand    start='^layout '                  end='$' oneline contains=muxLayoutValue
syn region muxString    matchgroup=muxSubCommand start='^  \(cd\|run\) '           end='$' oneline

" Can't use 'syn-keyword' because the option iskeyword doesn't include '-'.
syn match muxLayoutValue contained "\<\(even-horizontal\|even-vertical\|main-horizontal\|main-vertical\|tiled\)\>"
syn match muxSplitValue  contained "\<\d\+\>"

hi def link muxComment     Comment
hi def link muxCommand     Keyword
hi def link muxSubCommand  Type
hi def link muxString      String
hi def link muxLayoutValue Number
hi def link muxSplitValue  Number

let b:current_syntax = 'mux'
