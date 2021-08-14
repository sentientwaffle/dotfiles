if exists("b:current_syntax")
  finish
endif

" TODO: "# XXX?" should highlight as "# XXX"
" TODO: "\" (scan) should highlight the same as "/" (over)

set iskeyword=a-z,A-Z,?,48-57,_ ",192-255
setlocal tabstop=50

let s:opchars='[/\\''*&]:\?'
"let s:idchars='[¬⌋⌉!⇐⇒⇅~$&∆∇⋄]'
"let s:idchars='[&]'
"let s:dyads='[+−×÷%<>≤≥=≠↓↑⇔∨∧▼▲∋^∘∙@]'
let s:globals='[§∅❮❯]'
let s:monads='[!~$∆∇¬⌋⌉⇐⇒⇅∎¶±⊳∑ι∫]'
let s:dyads='[@^+−×÷%≤≥<>=≠↓↑⇔∨∧▼▲∋∘∙↦]'

syn match iSquare "[[\]]"
syn match iCurly  "[{}]"
syn match iParen  "[()]"

syn keyword iTodo TODO FIXME XXX NOTE contained
syn region iComment start="#"   end="$"   excludenl contains=iTodo,@Spell
syn region iComment start="###" end="###" excludenl contains=iTodo,@Spell

" Numbers, dates etc
syn match iNumber "-\=\d\+\(e[+-]\=\d\+\)\="
syn match iNumber "-\=\(\d\+\)\.\d\+\(e[+-]\=\d\+\)\="
syn match iNumber "[∞Ø]\|-∞"
" Hex
syn match iNumber "0x\x*"

syn match iSeparator ";"

" Identifiers not caught elsewhere
"syn match iGlobal "\<\u[A-Z0-9]*\>"

let s:ident='\<\([_a-zA-Z][_a-zA-Z0-9\?]*\|'.s:dyads.'\|'.s:opchars.'\)\>'
exec 'syn match iIdentifier "'. s:ident .'"'
"exec 'syn match iFunction   "'. s:ident .'\(\[\|@\)\@="'
exec 'syn match iOperator   "'. s:opchars .'"'
exec 'syn match iMonad      "'. s:monads .'"'
exec 'syn match iDyad       "'. s:dyads .'"'
exec 'syn match iGlobal     "'. s:globals .'"'
"exec 'syn match iFunction   "'. s:ident .'\(\[\)@="'

syn match iConditional "?\["me=e-1
syn match iConditional ":"

exec 'syn match iSymbol "`'.  s:ident .'"'
exec 'syn match iSymbol "\.'. s:ident .'"'
" String and handle embedded tabs and newlines correctly
syn region iString start=+"+  skip=+\\\\\|\\"+ end=+"+ keepend excludenl matchgroup=None contains=iSpecialChar
syn region iSymbol start=+`"+ skip=+\\\\\|\\"+ end=+"+ keepend excludenl matchgroup=None contains=iSpecialChar
"exec 'syn match iSymbol "`\('.s:monads.'\|'.s:dyads.'\|'.s:idsyms.'\)"'
"exec 'syn match iSymbol "`'. s:ident .'"'
"\('.s:monads.'\|'.s:dyads.'\|'.s:idsyms.'\)"'

"exec 'syn match iMonad "'. s:idchars .'"'
"exec 'syn match iDyad  "'. s:dyads  .'"'

"syn match iSpecialChar "\\[abcfnrtv\\]" contained
" special singlechar string before $
"syn match iCast /"\a"\$/

"syn keyword iPrimitive abs acos asin atan avg bin binr by cor cos cov delete dev div do enlist exec exit exp from getenv if in insert last like log max min prd reval select setenv sin sqrt ss sum svar tan update var wavg while within wsum xexp

hi link iBoolean Boolean
hi link iNumber Number
hi link iString String
hi link iDyad Operator
hi link iMonad Function
hi link iGlobal Type

hi link iCast Type
hi link iComment Comment
hi link iConditional Conditional
hi link iContext Directory
hi link iError Error
"hi link iExit WarningMsg
"hi link iFunction Function
hi link iFunction Normal
"hi link iHandle TabLineSel
hi link iIdentifier Normal
"hi link iLang Pmenu
hi link iOperator Conditional
"hi link iPlaceholder Normal
hi link iPreproc PreProc
hi link iPrimitive iFunction
"hi link iRepeat Repeat
hi link iSeparator Normal
"hi link iSpecial Special
hi link iSpecialChar SpecialChar
"hi link iSpecialComment Comment
hi link iSyscmd PmenuSel
hi link iSymbol Constant
hi link iTodo Todo

"hi link iMonad Operator
"hi link iDyad  Operator

hi link iSeparator Special
hi link iSquare Special
hi link iCurly Macro
hi link iParen Special

let b:current_syntax = "iota"
