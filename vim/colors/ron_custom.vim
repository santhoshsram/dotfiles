" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ron Aaron <ron@ronware.org>
" Last Change:	2003 May 02

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ron_custom"
hi comment		ctermfg=68
hi constant		ctermfg=207
hi precondit    cterm=NONE ctermfg=166
hi Todo			ctermfg=241
hi label		ctermfg=202
hi clear Visual
hi Visual		term=reverse cterm=reverse
hi cursorline   term=underline cterm=none ctermbg=235 ctermfg=none
hi type         term=underline cterm=none ctermbg=none ctermfg=10
hi specialchar  term=none cterm=none ctermbg=none ctermfg=213
hi Function     term=bold cterm=bold ctermfg=10 ctermbg=none
hi PreProc      term=none cterm=none ctermfg=172 ctermbg=none
