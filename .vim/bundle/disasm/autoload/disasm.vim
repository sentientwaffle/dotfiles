if exists('g:loaded_disasm')
  finish
endif
let g:loaded_disasm = 1
let s:address_pattern = '0x[0-9a-fA-Z]\{8\}'

function disasm#RenameCurrentFunction()
  let address = expand('<cWORD>')
  if !s:isAddress(address)
    echomsg 'No address found: ' . address
    return
  endif
  let fnName = input('Enter function name: ')
  if fnName ==# ''
    return
  endif

  let view = winsaveview()
  execute '%substitute/jal ' . address . '/jal ' . address . ' ; → ' fnName . '()/'
  execute '%substitute/^' . address . '/; function ' . fnName . '()\r' . address . '/'
  call winrestview(view)
endfunction

function disasm#RenameCurrentString()
  let address = expand('<cWORD>')
  if !s:isAddress(address)
    echomsg 'No address found: ' . address
    return
  endif
  let strName = input('Enter string description: ')
  if strName ==# ''
    return
  endif

  let view = winsaveview()
  silent execute 'global/ ' . address . ' /substitute/$/ @' . strName . '/'
  call winrestview(view)
  nohlsearch
endfunction

function s:isAddress(address)
  return a:address =~ s:address_pattern
endfunction
