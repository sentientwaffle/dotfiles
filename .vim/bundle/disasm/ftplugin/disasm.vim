if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal filetype=disasm

nnoremap <buffer> <LocalLeader>f :call disasm#RenameCurrentFunction()<CR>
nnoremap <buffer> <LocalLeader>s :call disasm#RenameCurrentString()<CR>
