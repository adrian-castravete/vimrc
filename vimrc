set nocompatible

filetype off
call plug#begin()
" Wombat 256 colorscheme
Plug 'vim-scripts/wombat256.vim'


" General
Plug 'ctrlpvim/ctrlp.vim'		" Fuzzy File Finder
Plug 'airblade/vim-gitgutter'		" Git gutter
Plug 'luochen1990/rainbow'		" Context highlighter
Plug 'majutsushi/tagbar'		" Tags manager
Plug 'wellle/context.vim'		" Current context
Plug 'mhinz/vim-startify'		" Fancy startup screen
Plug 'ap/vim-css-color'			" CSS color colouring
Plug 'junegunn/fzf'			" Fuzzy finder
Plug 'junegunn/fzf.vim'			" Fuzzy finder VIM
"Plug 'psliwka/vim-smoothie'		" Smooth scrolling
"Plug 'tpope/vim-fugitive'		" Git commands
"Plug 'MattesGroeger/vim-bookmarks'	" Bookmark plugin (`m*')
"Plug 'chrisbra/unicode.vim'		" Unicode related (`:SearchUnicode')
"Plug 'vim-syntastic/syntastic'		" Syntax checker
"Plug 'tpope/vim-abolish'		" For Subvert (`:%S')
"Plug 'Lenovsky/nuake'			" Quake style terminal (``')

" File types
Plug 'gabrielelana/vim-markdown'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'marcuscf/vim-lua'
Plug 'vim-scripts/confluencewiki.vim'
Plug 'tikhomirov/vim-glsl'
"Plug 'plasticboy/vim-markdown'
"Plug 'mzlogin/vim-markdown-toc'
"Plug 'JamshedVesuna/vim-markdown-preview'
"Plug 'neovimhaskell/haskell-vim'
"Plug 'kchmck/vim-coffee-script'
"Plug 'samsaga2/vim-z80'
"Plug 'leafo/moonscript-vim'
"Plug 'sentientmachine/Pretty-Vim-Python'
"Plug 'udalov/kotlin-vim'
"Plug 'leafOfTree/vim-vue-plugin'
"Plug 'habamax/vim-godot'

" Fennel (git@github.com:bakpakin/Fennel)
Plug 'bakpakin/fennel.vim'

" Clojure
"Plug 'tpope/vim-fireplace'
"Plug 'adrian-castravete/vim-parinfer'
Plug 'bhurlow/vim-parinfer'
call plug#end()
filetype plugin indent on

" My settings
" ===========
set t_Co=256
set autochdir
set hlsearch
set encoding=utf8
set shiftwidth=8
set tabstop=8
set backspace=2
set nowrap
set noshowmode
set list
set listchars=tab:»·,trail:•,nbsp:★,extends:»,precedes:«
set cursorline
set mouse=a
set colorcolumn=80,100,120
set signcolumn=yes
set laststatus=1
set ruler
set scrolloff=6
set modelines=10
set guicursor=
if !has('nvim')
	set guioptions=get
endif

" Italics
" =======
if (has('win32') || has('win64') || has('win16'))
	set guifont=CodeNewRoman_Nerd_Font_Mono:h12
else
	let &t_ZH="\e[3m"
	let &t_ZR="\e[23m"
	set guifont=CodeNewRoman\ Nerd\ Font\ Mono\ 12
endif

syntax enable

" Colours
" -------
set background=dark

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

colorscheme wombat256mod
colorscheme mydefault

" Keyboard mappings
" -----------------
nnoremap <Tab>  :wincmd w<cr>
nnoremap <C-O>  :bn<cr>
nnoremap <C-S>  :Ag<cr>
nnoremap <C-B>  :buffers<cr>:buffer<space>
nnoremap <F1>   :TagbarToggle<cr>
nnoremap <F2>   :w<cr>
nnoremap <F3>   :CtrlP<cr>
nnoremap <F5>   :make!<cr>
nnoremap <F6>   :tabnext<cr>
nnoremap <F7>   :Startify<cr>
cnoremap w!!    w !sudo tee > /dev/null %
nnoremap gb     :call SynStack()<cr>
"nnoremap <C-F>  :Files<cr>
"nnoremap <C-G>  :GFiles<cr>
"nnoremap <C-P>  :ProjectFiles<cr>
"nnoremap `      :Nuake<cr>

" Unicode
" -------
if !exists("g:startup_finished") || !g:startup_finished
	set encoding=utf-8
endif
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,latin1
set fileformat=unix

" Ignores
" -------
set wildignore+=node_modules
set wildignore+=__pycache__
set wildignore+=*.egg-info
set wildignore+=*.pyc

" Commands
" --------
command! ProjectFiles execute 'Files' FindGitRoot()

" Autocommands
" ------------
augroup wipetrailing
	autocmd!
	autocmd BufWritePre *.py,*.c,*.js,*.coffee,*.lua,*.fnl,*.fennel,*.clj,*.cljs,*.cljc :%s/\s\+$//e
augroup END

augroup customtabstops
	autocmd!
	autocmd BufNewFile,BufReadPre,BufCreate *.c,*.cc,*.cpp,*.cxx,*.h,*.asm,*.a :set ts=8 sw=8 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.json,*.py,*.java,*.kt,*.kts,*.md,*.markdown :set ts=4 sw=4 et
	autocmd BufNewFile,BufReadPre,BufCreate *.moon :set ts=4 sw=4 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.lua,*.script :set ts=3 sw=3 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.js,*.yaml,*.yml,*.jsx,*.fnl,*.fennel,*.jinja2,*.jinja,*.html,*.R,*.vue,*.rst :set ts=2 sw=2 et
	autocmd BufNewFile,BufReadPre,BufCreate *.gd :set ts=3 sw=3 noet
	autocmd FileType make :set ts=8 sw=8 noet
	autocmd FileType fennel :set ts=2 sw=2 et fdm=marker fmr=<<<,>>> "isk-=. isk-=:
augroup END

" Plugin specific configuration
" -----------------------------
" ### GitGutter ###
let g:gitgutter_set_sign_backgrounds = 1

" ### VIM markdown
let g:vim_markdown_folding_disabled = 1

" ### Parinfer ###
"let g:vim_parinfer_filetypes = ["fennel"]

" ### Rainbow ###
let g:rainbow_active = 1

" ### Context ###
let g:context_enabled = 0

" ### Syntastic ###
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_mode_map = { "mode": "passive" }
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

" ### FZF ###
"let g:fzf_layout = { 'down': '75%' }
"let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" ### Others ###
let g:netrw_keepdir = 0

" Functions
" ---------
function! SynStack()
	if !exists("*synstack")
		return
	endif
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunc

function! FindGitRoot()
	return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunc
