" Partially borrowed from https://github.com/katusk/vim-qkdb-syntax/blob/1e96918f8243493c86dd39cb6be02d8db7974816/syntax/k.vim

if exists("b:current_syntax")
  finish
endif

" Operator
syn match kOperator "[/\']:\?"

syn match kVerb "[:+\-*%!&|<>=~,^#_$? @.]"
syn match kGroup "[(){}\[\]]"

" highlight Todo and friends in comments
syn keyword kTodo TODO FIXME FIX XXX NOTE GOTCHA contained

" Exit
syn match kExit "^\\\\" contained

" Comments, trailing, wholeline and multi-line
syn region kComment start="^\s*/" end="$" keepend excludenl contains=kTodo
syn region kComment start="\s/" end="$" keepend excludenl contains=kTodo
" multiline comment, bare \ means rest of file is comment
syn region kComment start="^\\\\*\s*$" end="\%$" contains=kTodo,kExit
" multiline comment start / .. end \
syn region kComment start="^/\s*$" end="^\\\s*$" keepend excludenl contains=kTodo
" emphasised comment
syn region kSpecialComment start="^\s*//" end="$" keepend excludenl contains=kTodo
syn region kSpecialComment start="\s//" end="$" keepend excludenl contains=kTodo

" Numbers, dates etc
syn match kNumber "-\=\(\d\+\)\=\.\d*\(e[+-]\=\d\+\)\=[ef]\="
syn match kNumber "-\=\d\+\(e[+-]\=\d\+\)\=[ijhfe]\="
" Timestamp
"syn match kNumber "\d\{4}\.[01]\d\.[0123]\dT[012]\d\:[012345]\d:[012345]\d\(\.\d\+\)\="
" Month
"syn match kNumber "\d\{4}\.[01]\dm"
" Time
"syn match kNumber "[012]\d:[012345]\d\(:[012345]\d\(\.\d\+\)\=\)\="
" Hex
syn match kNumber "0x\x*"

" special functions 0: 1: 2:
syn match kFunction "\<[012]:"

" Boolean
syn match kBoolean /[01]\+b/

" generic .?.* match - single letter reserved namespace
" syn match kFunction /\.\a\.\a[a-zA-Z0-9]*/

"Statement separator
syn match kSeparator ";"

" all the nulls and INFs
syn keyword kSpecial 0N 0W 0n 0w
syn match kSpecial "-0[wW]"
syn match kSpecial "-0W[defhijmnptuvz]"
syn match kSpecial "0[NW][defghijmnptuvz]"
" GUIDs
"syn match kSpecial "[-[:xdigit:]]\{36}"

" Identifiers not caught elsewhere
syn match kGlobal "\<\u[A-Z0-9]*\>"

syn match kIdentifier "\<[a-zA-Z\.][a-zA-Z0-9\.]*\>"

" k primitives from .Q.res
syn keyword kPrimitive abs acos asin atan avg bin binr by cor cos cov delete dev div do enlist exec exit exp from getenv if in insert last like log max min prd reval select setenv sin sqrt ss sum svar tan update var wavg while within wsum xexp

" catch invalid .?.?/?.??
syn match kError "\.[a-zA-Z]\.[a-zA-Z]*"

"syn match kIdentifier "\<\a[a-zA-Z0-9]*\>"
"syn match kIdentifier "\<[a-zA-Z\.][a-zA-Z0-9\.]*\>"
syn match kPlaceholder "\<[xyz]\>"

" Conditional and similar constructs
syn keyword kConditional if
syn match kConditional /$\[/me=e-1
syn match kConditional /?\[/me=e-1
syn match kConditional /'\[/me=e-1
syn match kConditional /\.\[/me=e-1
syn match kConditional /@\[/me=e-1

" plist, view, global assign
syn match Function /::/

" Repeat
syn keyword kRepeat do while

" in a k script q) and s) switch to other languages, k) is unnecessary
"syn match kLang "^q)"
"syn match kLang "^s)"
"syn match kError "^k)"

" symbols and specialcase file+connection handles
syn match kSymbol "\(`\<[a-zA-Z0-9\.][a-zA-Z0-9_\.]*\>\)"
syn match kHandle "\`:\{1,2}\([0-9a-zA-Z_\\/.]\+:\=\)\{1,4}"

" attributes `p#, `g#, `s# and `u#
"syn match kPreproc /`[spgu]#/

" highlight all the special names used when `XXX$ casting data
"syn match kCast "\`\(boolean\|byte\|short\|int\|long\|real\|guid\|float\|char\|symbol\|timestamp\|month\|date\|datetime\|timespan\|time\|minute\|second\)\$\s*"
"syn match kCast "\`\(year\|week\|mm\|dd\|hh\|ss\|uu\)\$\s*"

" system cmd
syn match kSyscmd "^\\\<\([12abBcCdeflopPrsStTuvwWxz_]\|cd\|ts\)\>"

" String and handle embedded tabs and newlines correctly
syn region kString start=+"+ skip=+\\\\\|\\"+ end=+"+ keepend excludenl matchgroup=None contains=kSpecialChar
syn match kSpecialChar "\\[abcfnrtv\\]" contained
" special singlechar string before $
syn match kCast /"\a"\$/

hi link kBoolean Boolean
hi link kNumber Number
hi link kString String

hi link kCast Type
hi link kComment Comment
hi link kConditional Conditional
hi link kContext Directory
hi link kError Error
hi link kExit WarningMsg
hi link kFunction Function
hi link kGlobal Macro
hi link kHandle TabLineSel
hi link kIdentifier Normal
"hi link kLang Pmenu
hi link kOperator Operator
hi link kPlaceholder Normal
hi link kPreproc PreProc
hi link kPrimitive kFunction
hi link kRepeat Repeat
hi link kSeparator Normal
hi link kSpecial Special
hi link kSpecialChar SpecialChar
hi link kSpecialComment Comment
hi link kSyscmd PmenuSel
hi link kSymbol Constant
hi link kTodo Todo

hi link kVerb Function
hi link kGroup Macro

let b:current_syntax = "k"
