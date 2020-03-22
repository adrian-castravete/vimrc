set nocompatible

" Vundle
" ======

set rtp+=~/.vim/Vundle.vim
filetype off
call vundle#begin()
" General
Plugin 'tpope/vim-fugitive'             " Git commands
Plugin 'MattesGroeger/vim-bookmarks'    " Bookmark plugin (`m*')
Plugin 'luochen1990/rainbow'            " Context highlighter
Plugin 'majutsushi/tagbar'              " Tags manager (``')
Plugin 'rking/ag.vim'                   " Silver searcher (`:Ag')
Plugin 'chrisbra/unicode.vim'           " Unicode related (`:SearchUnicode')
Plugin 'wellle/context.vim'             " Current context

" File types
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'tikhomirov/vim-glsl'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'samsaga2/vim-z80'
Plugin 'leafo/moonscript-vim'

" Fennel (git@github.com:bakpakin/Fennel)
Plugin 'bakpakin/fennel.vim'

" Clojure
Plugin 'tpope/vim-fireplace'
Plugin 'adrian-castravete/vim-parinfer'
call vundle#end()
filetype plugin indent on

" My settings
" ===========
"set t_Co=256
set autochdir
set hlsearch
set encoding=utf8
set shiftwidth=8
set tabstop=8
set backspace=2
set nowrap
set noshowmode
set list
set listchars=tab:»‧,trail:•,nbsp:★,extends:»,precedes:«
set guicursor=
"set cursorline
set mouse=

syntax enable

" Colours
" -------
set background=dark
"colorscheme seoul256
set laststatus=2
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

highlight DiffAdd       cterm=reverse   ctermbg=15  ctermfg=2
highlight DiffDelete    cterm=reverse   ctermbg=15  ctermfg=1
highlight DiffChange    cterm=reverse   ctermbg=15  ctermfg=3
highlight DiffText      cterm=reverse   ctermbg=15  ctermfg=8

colorscheme mydefault

" Keyboard mappings
" -----------------
nnoremap <Tab>  :wincmd w<cr>
nnoremap <C-O>  :bn<cr>
nnoremap <F5>   :buffers<cr>:buffer<space>
nnoremap `      :TagbarToggle<cr>
nnoremap <C-G>  :silent grep!<space> -- :/<cr>:cw<cr>
cnoremap w!!    w !sudo tee > /dev/null %
nnoremap gb     :call SynStack()<cr>

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

" Autocommands
" ------------
augroup wipetrailing
autocmd!
autocmd BufWritePre *.py,*.c,*.js,*.coffee,*.lua,*.fnl,*.fennel,*.clj,*.cljs,*.cljc :%s/\s\+$//e
augroup END

augroup customtabstops
autocmd!
autocmd BufNewFile,BufReadPre,BufCreate *.c,*.cc,*.cpp,*.cxx,*.h,*.asm,*.a :set ts=8 sw=8 noet
autocmd BufNewFile,BufReadPre,BufCreate *.lua,*.js,*.yaml,*.jsx,*.jinja2,*.jinja,*.html :set ts=2 sw=2 et
autocmd BufNewFile,BufReadPre,BufCreate *.json,*.py :set ts=4 sw=4 et
autocmd FileType make :set ts=8 sw=8 noet
augroup END

" Plugin specific configuration
" -----------------------------

" ### Parinfer ###
let g:vim_parinfer_filetypes = ["fennel"]

" ### Rainbow ###
let g:rainbow_active = 0

" ### Context ###
let g:context_enabled = 0

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
