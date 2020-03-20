set background=dark
highlight clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "mydefault"

highlight Normal			ctermbg=NONE
highlight NonText			ctermbg=NONE	ctermfg=8
highlight SpecialKey			ctermbg=NONE	ctermfg=8

highlight DiffAdd	cterm=reverse	ctermbg=15	ctermfg=2
highlight DiffDelete	cterm=reverse	ctermbg=15	ctermfg=1
highlight DiffChange	cterm=reverse	ctermbg=15	ctermfg=3
highlight DiffText	cterm=reverse	ctermbg=15	ctermfg=8

highlight Comment	cterm=italic			ctermfg=2
highlight Number					ctermfg=14
highlight String					ctermfg=9
