" = TODO
" * WildMenu and Pmenu should be more similar
" * 243 vs 222

" https://github.com/tomasr/molokai/blob/c67bdfcdb31415aa0ade7f8c003261700a885476/colors/molokai.vim
" https://github.com/sickill/vim-monokai/blob/master/colors/monokai.vim
" https://github.com/ErichDonGubler/vim-sublime-monokai/blob/master/colors/sublimemonokai.vim

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'custom'

hi Normal          ctermfg=252 ctermbg=232
hi CursorLine                                cterm=none
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
hi Boolean         ctermfg=243
hi Character       ctermfg=243
hi Number          ctermfg=243
hi String          ctermfg=243
hi Float           ctermfg=243
hi Constant        ctermfg=252 cterm=italic
hi Debug           ctermfg=225               cterm=bold
hi Define          ctermfg=243
hi Delimiter       ctermfg=241
hi Include         ctermfg=247

hi Function        ctermfg=247 cterm=italic
" json object key
hi Label           ctermfg=247 cterm=italic
hi Special         ctermfg=247 cterm=italic
" js regexp
hi SpecialChar     ctermfg=247

hi Ignore          ctermfg=244 ctermbg=232

hi Macro           ctermfg=248 ctermbg=233
hi PreCondit       ctermfg=248 ctermbg=233   cterm=bold
hi PreProc         ctermfg=248 ctermbg=233

hi MatchParen      ctermfg=233 ctermbg=251
hi ModeMsg         ctermfg=243
hi MoreMsg         ctermfg=229

" Keywords
hi Keyword         ctermfg=250 cterm=bold
hi Conditional     ctermfg=250 cterm=bold
hi Repeat          ctermfg=250 cterm=bold
hi Operator        ctermfg=255
hi Exception       ctermfg=247 cterm=italic
hi Statement       ctermfg=247 cterm=italic
"hi Tag            ctermfg=166

hi Question        ctermfg=247   cterm=italic
hi Search          ctermfg=232   ctermbg=250   cterm=none
hi IncSearch       ctermfg=232   ctermbg=255   cterm=none

" marks column
hi SignColumn      ctermfg=243 ctermbg=235
if has('spell')
  hi SpellBad                ctermbg=none  cterm=underline
  hi SpellCap                ctermbg=17    cterm=underline
  hi SpellLocal              ctermbg=17    cterm=underline
  hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
endif
hi Title           ctermfg=255 cterm=bold

" Type definitions
hi Typedef         ctermfg=249 cterm=italic
hi Type            ctermfg=249 cterm=italic
hi Identifier      ctermfg=252 cterm=bold
hi StorageClass    ctermfg=252 cterm=bold
hi Structure       ctermfg=250 cterm=bold

" JavaScript
hi jsObjectKey        ctermfg=243

hi Underlined      ctermfg=244               cterm=underline

hi VisualNOS                   ctermbg=238
hi Visual                      ctermbg=234

" Comments
hi Comment         ctermfg=250 ctermbg=235
hi SpecialComment  ctermfg=243
hi Todo            ctermfg=231 ctermbg=232  cterm=bold

" listchars
hi SpecialKey      ctermfg=59  ctermbg=233

" -----------------------------------------------------------------------------
" Widgets
" -----------------------------------------------------------------------------

" Gutter
hi LineNr          ctermfg=239 ctermbg=233
hi CursorLineNr    ctermfg=234 ctermbg=243   cterm=none
hi NonText         ctermfg=59
if has('folding')
  hi FoldColumn    ctermfg=253  ctermbg=16
  hi Folded        ctermfg=253  ctermbg=16
endif

" Completion menu
hi Pmenu           ctermfg=253 ctermbg=235
hi PmenuSel        ctermfg=255 ctermbg=242   cterm=bold
hi PmenuSbar                   ctermbg=232
hi PmenuThumb      ctermfg=247
hi WildMenu        ctermfg=255 ctermbg=242
"hi WildMenu        ctermfg=250  ctermbg=16

" Statusline, Tabline
hi StatusLine      ctermfg=244 ctermbg=234   cterm=none
hi StatusLineNC    ctermfg=243 ctermbg=232   cterm=none
hi TabLineFill     ctermfg=249 ctermbg=234   cterm=underline
hi TabLine         ctermfg=249 ctermbg=234   cterm=underline
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
hi diffRemoved     ctermfg=167
hi diffIndexLine   ctermfg=250 ctermbg=235
hi diffLine        ctermfg=250 ctermbg=235
hi diffFile        ctermfg=250 ctermbg=235

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------

hi gitcommitBranch        ctermfg=250
hi gitcommitSelectedType  ctermfg=107
hi gitcommitSelectedFile  ctermfg=107
hi gitcommitDiscardedType ctermfg=250
hi gitcommitDiscardedFile ctermfg=250
hi gitcommitUntrackedType ctermfg=245 cterm=italic
hi gitcommitUntrackedFile ctermfg=245 cterm=italic

" -----------------------------------------------------------------------------
" HTML / XML
" -----------------------------------------------------------------------------
hi htmlTag            ctermfg=245 cterm=italic
hi htmlTagN           ctermfg=245 cterm=italic
hi htmlTagName        ctermfg=245 cterm=italic
hi htmlEndTag         ctermfg=245 cterm=italic
hi htmlSpecialTagName ctermfg=245 cterm=italic
" un-highlight
hi htmlTitle          ctermfg=252
hi htmlHead           ctermfg=252
" XML
hi xmlTag             ctermfg=245 cterm=italic
hi xmlTagName         ctermfg=245 cterm=italic
hi xmlNamespace       ctermfg=243
hi xmlEndTag          ctermfg=245 cterm=italic

" -----------------------------------------------------------------------------
" Netrw
" -----------------------------------------------------------------------------
hi Directory       ctermfg=107
hi netrwClassify   ctermfg=166

" -----------------------------------------------------------------------------
" Journal
" -----------------------------------------------------------------------------
hi journalMetadataKey ctermfg=243
"hi journalLink        ctermfg=67   cterm=underline
"hi journalCode        ctermfg=243
"hi journalBlockQuote  ctermfg=245 cterm=italic
hi journalBold        cterm=bold
hi journalItalic      cterm=italic
"hi journalFlashcardProperty  ctermfg=
"hi journalURLDelimiter  
hi journalURLTitle      ctermfg=254
hi journalURLHref       ctermfg=248 cterm=italic

" -----------------------------------------------------------------------------
" Markdown
" -----------------------------------------------------------------------------

hi markdownCode          ctermfg=243
hi markdownCodeBlock     ctermfg=243
hi markdownAutomaticLink ctermfg=248 cterm=italic

" -----------------------------------------------------------------------------
" Rust
" -----------------------------------------------------------------------------
hi rustType        ctermfg=250      cterm=bold

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
