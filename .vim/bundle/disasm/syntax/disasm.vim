if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

" ------------------------------------------------------------------------------
" Matching
" ------------------------------------------------------------------------------

syn region  disasmOffset      start="^0x" end=" \+" oneline nextgroup=disasmOpcodes
syn match   disasmOpcodes     "[0-9a-fA-F]\+" contained

syn match   disasmCommand     "  \w\+\>"
syn match   disasmInvalid     "  invalid$"
syn match   disasmNop         "  nop$"
syn match   disasmJump        "  [jb]\w*\>"
syn match   disasmMemory      "  \(lw\|lh\|lhu\|lb\|lbu\|sw\|sh\|sb\|lui\|mfhi\|mflo\|mfc\.\|mtc\.\)\>"

syn keyword disasmRegister    zero at v0 v1 a0 a1 a2 a3 t0 t1 t2 t3 t4 t5 t6 t7 s0 s1 s2 s3 s4 s5 s6 s7 t8 t9 k0 k1 gp sp fp ra
syn match   disasmNumber      " -\?0x[0-9a-fA-F]\+\>"
syn match   disasmNumber      " -\?[0-9]\+\>"
syn region  disasmComment     start=";"   end="$" oneline contains=disasmCommentTodo
syn keyword disasmCommentTodo TODO XXX FIXME contained

" ------------------------------------------------------------------------------
" Groups
" ------------------------------------------------------------------------------

hi def link disasmOffset      Macro
hi def link disasmOpcodes     Comment

hi def link disasmCommand     Keyword
hi def link disasmInvalid     Error
hi def link disasmNop         Ignore
hi def link disasmJump        Question
hi def link disasmMemory      Function

hi def link disasmRegister    String
hi def link disasmNumber      Number
hi def link disasmComment     Comment
hi def link disasmCommentTodo Todo
