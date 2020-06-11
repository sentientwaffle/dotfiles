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

"let red = '#dd5f66' -- keyword
"let red_orange = '#f97b58' -- operator
"let pink = '#F07178' or #c794c7 -- macro
"let orange = '#F78C6C' -- identifier
"let yellow = '#FFCB6B' -- string
"let green = '#C3E88D' -- function
"let pale_blue = '#B2CCD6'
"let cyan = '#89DDFF' -- type
"let blue = '#82AAFF'
"let purple = '#C792EA'
"let violet = '#BB80B3' -- number
"let brown = '#AB7967'

" Constants
hi Boolean         ctermfg=176
hi Character       ctermfg=221
hi Number          ctermfg=176
hi String          ctermfg=221
hi Float           ctermfg=176
hi Constant        ctermfg=176
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=221
hi Delimiter       ctermfg=241
hi Include         ctermfg=117

hi Function        ctermfg=150
" json object key
hi Label           ctermfg=150
hi Special         ctermfg=137
" js regexp
hi SpecialChar     ctermfg=167

hi Ignore          ctermfg=244 ctermbg=232

hi Macro           ctermfg=176
hi PreCondit       ctermfg=176               cterm=bold
hi PreProc         ctermfg=176

hi MatchParen      ctermfg=233 ctermbg=251
hi ModeMsg         ctermfg=221
hi MoreMsg         ctermfg=229

" Keywords
hi Keyword         ctermfg=167
hi Conditional     ctermfg=167
hi Repeat          ctermfg=167
hi Operator        ctermfg=209
hi Exception       ctermfg=150
hi Statement       ctermfg=150
"hi Tag            ctermfg=166

hi Question        ctermfg=117
hi Search          ctermfg=0   ctermbg=221   cterm=none
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
hi Typedef         ctermfg=117
hi Type            ctermfg=117
hi Identifier      ctermfg=209               cterm=none
hi StorageClass    ctermfg=209
hi Structure       ctermfg=117

" JavaScript
hi jsObjectKey        ctermfg=221

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
hi LineNr          ctermfg=241 ctermbg=234
hi CursorLineNr    ctermfg=234 ctermbg=241   cterm=none
hi NonText         ctermfg=59
if has('folding')
  hi FoldColumn    ctermfg=253  ctermbg=16
  hi Folded        ctermfg=253  ctermbg=16
endif

" Completion menu
hi Pmenu           ctermfg=253 ctermbg=235
hi PmenuSel        ctermfg=255 ctermbg=242   cterm=bold
hi PmenuSbar                   ctermbg=232
hi PmenuThumb      ctermfg=117
hi WildMenu        ctermfg=255 ctermbg=242
"hi WildMenu        ctermfg=117  ctermbg=16

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
hi DiffText        ctermfg=102 cterm=bold
" filetype=diff
hi diffAdded       ctermfg=107
hi diffChanged     ctermfg=181
hi diffRemoved     ctermfg=160
hi diffIndexLine   ctermfg=117
hi diffLine        ctermfg=176

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------

hi gitcommitSelectedType  ctermfg=107
hi gitcommitSelectedFile  ctermfg=107
hi gitcommitDiscardedType ctermfg=160
hi gitcommitDiscardedFile ctermfg=160
hi gitcommitUntrackedType ctermfg=160
hi gitcommitUntrackedFile ctermfg=160

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
hi journalMetadataKey ctermfg=221
"hi journalLink        ctermfg=67   cterm=underline
"hi journalCode        ctermfg=221
"hi journalBlockQuote  ctermfg=137
hi journalBold        cterm=bold
hi journalItalic      cterm=italic
"hi journalFlashcardProperty  ctermfg=

" -----------------------------------------------------------------------------
" Markdown
" -----------------------------------------------------------------------------

hi markdownCode      ctermfg=221
hi markdownCodeBlock ctermfg=221

" -----------------------------------------------------------------------------
" Rust
" -----------------------------------------------------------------------------
hi rustType        ctermfg=117      cterm=bold

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
