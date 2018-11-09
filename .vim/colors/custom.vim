" = TODO
" * WildMenu and Pmenu should be more similar
" * 221 vs 222

" https://github.com/tomasr/molokai/blob/c67bdfcdb31415aa0ade7f8c003261700a885476/colors/molokai.vim
" https://github.com/sickill/vim-monokai/blob/master/colors/monokai.vim
" https://github.com/ErichDonGubler/vim-sublime-monokai/blob/master/colors/sublimemonokai.vim

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'custom'

hi Normal          ctermfg=252 ctermbg=233
hi CursorLine                  ctermbg=234   cterm=none
hi Cursor          ctermfg=16  ctermbg=253

" Constants
hi Boolean         ctermfg=141
hi Character       ctermfg=222
hi Number          ctermfg=141
hi String          ctermfg=222
hi Float           ctermfg=141
hi Constant        ctermfg=141
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=241
hi Include         ctermfg=81

hi Function        ctermfg=154
" json object key
hi Label           ctermfg=197
hi Special         ctermfg=81
" js regexp
hi SpecialChar     ctermfg=197

hi Ignore          ctermfg=244 ctermbg=232

hi Macro           ctermfg=213
hi PreCondit       ctermfg=213               cterm=bold
hi PreProc         ctermfg=213

hi MatchParen      ctermfg=233  ctermbg=251
hi ModeMsg         ctermfg=221
hi MoreMsg         ctermfg=229

" Keywords
hi Keyword         ctermfg=197
hi Conditional     ctermfg=197
hi Repeat          ctermfg=197
hi Operator        ctermfg=197
hi Exception       ctermfg=154
hi Statement       ctermfg=154
"hi Tag            ctermfg=166

hi Question        ctermfg=81
hi Search          ctermfg=0   ctermbg=222   cterm=none
hi IncSearch       ctermfg=193 ctermbg=16

" marks column
hi SignColumn      ctermfg=221 ctermbg=235
if has('spell')
  hi SpellBad                ctermbg=none  cterm=underline
  hi SpellCap                ctermbg=17    cterm=underline
  hi SpellLocal              ctermbg=17    cterm=underline
  hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
endif
hi Title           ctermfg=166

" Type definitions
hi Typedef         ctermfg=81
hi Type            ctermfg=81
hi Identifier      ctermfg=208               cterm=none
hi StorageClass    ctermfg=208
hi Structure       ctermfg=81

" JavaScript
hi jsObjectKey        ctermfg=222

hi Underlined      ctermfg=244               cterm=underline

hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=235

" Comments
hi Comment         ctermfg=59
hi SpecialComment  ctermfg=245
hi Todo            ctermfg=231 ctermbg=232  cterm=bold

" listchars
hi SpecialKey      ctermfg=59  ctermbg=234

" -----------------------------------------------------------------------------
" Widgets
" -----------------------------------------------------------------------------

" Gutter
hi LineNr          ctermfg=250 ctermbg=236
hi CursorLineNr    ctermfg=107               cterm=none
hi NonText         ctermfg=59
hi FoldColumn      ctermfg=67  ctermbg=16
hi Folded          ctermfg=67  ctermbg=16

" Completion menu
hi Pmenu           ctermfg=253 ctermbg=235
hi PmenuSel        ctermfg=255 ctermbg=242   cterm=bold
hi PmenuSbar                   ctermbg=232
hi PmenuThumb      ctermfg=81
hi WildMenu        ctermfg=255 ctermbg=242
"hi WildMenu        ctermfg=81  ctermbg=16

" Statusline, Tabline
hi StatusLine      ctermfg=238 ctermbg=253   cterm=reverse
hi StatusLineNC    ctermfg=234 ctermbg=245   cterm=reverse
hi TabLineFill     ctermfg=253 ctermbg=238   cterm=underline
hi TabLine         ctermfg=253 ctermbg=238   cterm=underline
hi TabLineSel      ctermfg=253 ctermbg=none

hi VertSplit       ctermfg=253 ctermbg=238   cterm=none

hi CursorColumn                ctermbg=236
hi ColorColumn                 ctermbg=236

" Errors/warnings
hi Error           ctermfg=219 ctermbg=89
hi ErrorMsg        ctermfg=199 ctermbg=16
hi WarningMsg      ctermfg=231 ctermbg=none

" -----------------------------------------------------------------------------
" Diff
" -----------------------------------------------------------------------------
" vimdiff
hi DiffAdd         ctermfg=107
hi DiffChange      ctermfg=181
hi DiffDelete      ctermfg=160
hi DiffText        ctermfg=102             cterm=bold
" filetype=diff
hi diffAdded       ctermfg=107
hi diffChanged     ctermfg=181
hi diffRemoved     ctermfg=160

" -----------------------------------------------------------------------------
" HTML / XML
" -----------------------------------------------------------------------------
hi htmlTag            ctermfg=137
hi htmlTagN           ctermfg=137
hi htmlTagName        ctermfg=137
hi htmlEndTag         ctermfg=137
hi htmlSpecialTagName ctermfg=137
" un-highlight
hi htmlTitle          ctermfg=252
hi htmlHead           ctermfg=252
" XML
hi xmlTag             ctermfg=137
hi xmlTagName         ctermfg=137
hi xmlNamespace       ctermfg=221
hi xmlEndTag          ctermfg=137

" -----------------------------------------------------------------------------
" Netrw
" -----------------------------------------------------------------------------
hi Directory       ctermfg=107
hi netrwClassify   ctermfg=166

" -----------------------------------------------------------------------------
" Journal
" -----------------------------------------------------------------------------
hi journalMetadataKey ctermfg=221  cterm=bold
"hi journalLink        ctermfg=67   cterm=underline
hi journalCode        ctermfg=222
hi journalBold                     cterm=bold
hi journalItalic                   cterm=italic

" -----------------------------------------------------------------------------
" Rust
" -----------------------------------------------------------------------------
hi rustType        ctermfg=81      cterm=bold

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
