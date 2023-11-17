set nocompatible

" Vundle
" ======

if has('win32') || has('win64') || has('win16')
	set rtp+=~\vimfiles\Vundle.vim
else
	set rtp+=~/.vim/Vundle.vim
endif
filetype off
call vundle#begin()
" Wombat 256 colorscheme
Plugin 'wombat256.vim'


" General
Plugin 'ctrlpvim/ctrlp.vim'		" Fuzzy File Finder
Plugin 'airblade/vim-gitgutter'		" Git gutter
Plugin 'luochen1990/rainbow'		" Context highlighter
Plugin 'majutsushi/tagbar'		" Tags manager
Plugin 'wellle/context.vim'		" Current context
Plugin 'mhinz/vim-startify'		" Fancy startup screen
Plugin 'psliwka/vim-smoothie'		" Smooth scrolling
"Plugin 'junegunn/fzf'			" Fuzzy finder
"Plugin 'junegunn/fzf.vim'		" Fuzzy finder VIM
"Plugin 'tpope/vim-fugitive'		" Git commands
"Plugin 'MattesGroeger/vim-bookmarks'	" Bookmark plugin (`m*')
"Plugin 'chrisbra/unicode.vim'		" Unicode related (`:SearchUnicode')
"Plugin 'vim-syntastic/syntastic'	" Syntax checker
"Plugin 'tpope/vim-abolish'		" For Subvert (`:%S')
"Plugin 'Lenovsky/nuake'			" Quake style terminal (``')

" File types
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'vim-python/python-syntax'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'marcuscf/vim-lua'
"Plugin 'JamshedVesuna/vim-markdown-preview'
"Plugin 'tikhomirov/vim-glsl'
"Plugin 'neovimhaskell/haskell-vim'
"Plugin 'kchmck/vim-coffee-script'
"Plugin 'samsaga2/vim-z80'
"Plugin 'leafo/moonscript-vim'
"Plugin 'sentientmachine/Pretty-Vim-Python'
"Plugin 'udalov/kotlin-vim'
"Plugin 'leafOfTree/vim-vue-plugin'
"Plugin 'habamax/vim-godot'

" Fennel (git@github.com:bakpakin/Fennel)
"Plugin 'bakpakin/fennel.vim'

" Clojure
"Plugin 'tpope/vim-fireplace'
"Plugin 'adrian-castravete/vim-parinfer'
call vundle#end()
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
set guicursor=
set cursorline
set mouse=a
set colorcolumn=80,100,120
set signcolumn=yes
set laststatus=1
set ruler
set scrolloff=6
set modelines=10

" Italics
" =======
if !(has('win32') || has('win64') || has('win16'))
	let &t_ZH="\e[3m"
	let &t_ZR="\e[23m"
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
nnoremap <C-S>  :Rg<cr>
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
	autocmd BufNewFile,BufReadPre,BufCreate *.c,*.cc,*.cpp,*.cxx,*.h,*.asm,*.a :setlocal ts=8 sw=8 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.json,*.py,*.java,*.kt,*.kts :setlocal ts=4 sw=4 et
	autocmd BufNewFile,BufReadPre,BufCreate *.moon :setlocal ts=4 sw=4 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.lua,*.script :setlocal ts=3 sw=3 noet
	autocmd BufNewFile,BufReadPre,BufCreate *.js,*.yaml,*.yml,*.jsx,*.jinja2,*.jinja,*.html,*.fnl,*.fennel,*.R,*.vue :setlocal ts=2 sw=2 et
	autocmd BufNewFile,BufReadPre,BufCreate *.gd :setlocal ts=3 sw=3 noet
	autocmd FileType make :set ts=8 sw=8 noet
augroup END

" Plugin specific configuration
" -----------------------------
" ### GitGutter ###
let g:gitgutter_set_sign_backgrounds = 1

" ### VIM markdown
let g:vim_markdown_folding_disabled = 1

" ### Parinfer ###
let g:vim_parinfer_filetypes = ["fennel"]

" ### Rainbow ###
let g:rainbow_active = 0

" ### Context ###
let g:context_enabled = 0

" ### Syntastic ###
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
