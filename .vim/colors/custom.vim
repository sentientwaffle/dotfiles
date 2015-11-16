" = TODO
" * molokai violet: 135
" * WildMenu and Pmenu should be more similar

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="custom"

hi Normal          ctermfg=252 ctermbg=233
hi CursorLine                  ctermbg=234   cterm=none
hi Cursor          ctermfg=16  ctermbg=253

hi Character       ctermfg=107
hi String          ctermfg=107
" js regexp
hi SpecialChar     ctermfg=184

" Constants
" 135 -> 67,153
hi Boolean         ctermfg=67
hi Number          ctermfg=67
hi Float           ctermfg=67
hi Constant        ctermfg=67
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=241

" 118 -> 221
hi Function        ctermfg=221
" 81 -> 160
hi Special         ctermfg=160

hi Ignore          ctermfg=244 ctermbg=232

hi Label           ctermfg=229               cterm=none
hi Macro           ctermfg=137

hi MatchParen      ctermfg=233  ctermbg=251
hi ModeMsg         ctermfg=221
hi MoreMsg         ctermfg=229

" Keywords (161)
hi Keyword         ctermfg=166
hi Conditional     ctermfg=166
hi Repeat          ctermfg=166
hi Operator        ctermfg=166
hi Exception       ctermfg=166
hi Statement       ctermfg=166
"hi Tag            ctermfg=166

hi PreCondit       ctermfg=221               cterm=bold
hi PreProc         ctermfg=221
hi Question        ctermfg=81
hi Search          ctermfg=0   ctermbg=222   cterm=NONE
hi IncSearch       ctermfg=193 ctermbg=16

" marks column
hi SignColumn      ctermfg=221 ctermbg=235
if has("spell")
  hi SpellBad                ctermbg=none  cterm=underline
  hi SpellCap                ctermbg=17    cterm=underline
  hi SpellLocal              ctermbg=17    cterm=underline
  hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
endif
hi Title           ctermfg=166

" Type definitions
hi Typedef         ctermfg=153
hi Type            ctermfg=153               cterm=none
hi Identifier      ctermfg=153               cterm=none
hi StorageClass    ctermfg=153
hi Structure       ctermfg=153

hi Underlined      ctermfg=244               cterm=underline

hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=235

" Comments
hi Comment         ctermfg=59
hi SpecialComment  ctermfg=245               cterm=bold
hi Todo            ctermfg=198 ctermbg=none  cterm=bold

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
hi Error           ctermfg=231 ctermbg=162
hi ErrorMsg        ctermfg=160 ctermbg=none
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

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
