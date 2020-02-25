set nocompatible

" Vundle
" ======

set rtp+=~/.vim/Vundle.vim
filetype off
call vundle#begin()
" General
Plugin 'ryanoasis/vim-devicons'         " Beautiful icons
Plugin 'airblade/vim-gitgutter'         " Gutter markers for git modifications
Plugin 'easymotion'                     " Movement plugin (`\\')
Plugin 'mhinz/vim-startify'             " Awesome startup screen (`:Startify')
Plugin 'tpope/vim-fugitive'             " Git commands
Plugin 'MattesGroeger/vim-bookmarks'    " Bookmark plugin (`m*')
Plugin 'luochen1990/rainbow'            " Context highlighter
Plugin 'majutsushi/tagbar'              " Tags manager (``')
Plugin 'itchyny/lightline.vim'          " Status line
Plugin 'ap/vim-css-color'               " Colour colour definitions (ex: #55aaff)
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

" Themes
Plugin 'junegunn/seoul256.vim'

" Ctrl*
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dyng/ctrlsf.vim'
call vundle#end()
filetype plugin indent on

" My settings
" ===========
set t_Co=256
set autochdir
set hlsearch
set encoding=utf8
set expandtab
set shiftwidth=2
set tabstop=2
set backspace=2
set nowrap
set noshowmode
set list
set listchars=tab:»‧,trail:•,nbsp:★,extends:»,precedes:«
set guicursor=
set cursorline
set mouse=
colorscheme darkblue

syntax enable

" Colours
" -------
set background=dark
colorscheme seoul256
set laststatus=2
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

highlight DiffAdd       cterm=reverse   ctermbg=15  ctermfg=2
highlight DiffDelete    cterm=reverse   ctermbg=15  ctermfg=1
highlight DiffChange    cterm=reverse   ctermbg=15  ctermfg=3
highlight DiffText      cterm=reverse   ctermbg=15  ctermfg=8

" Keyboard mappings
" -----------------
nnoremap <Tab>  :wincmd w<cr>
nnoremap <C-O>  :bn<cr>
nnoremap <F5>   :buffers<cr>:buffer<space>
nnoremap `      :TagbarToggle<cr>
nnoremap <C-G>  :silent grep!<space> -- :/<cr>:cw<cr>
cnoremap w!!    w !sudo tee > /dev/null %

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

" ### Lightline ###
let g:lightline = {
\   'active': {
\     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], [ 'tagbar' ] ],
\   },
\   'colorscheme': 'seoul256',
\   'component': {
\     'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
\   },
\   'component_function': {
\     'filetype': 'LightLineFileType',
\     'fileformat': 'LightLineFileFormat',
\   },
\ }

" ### Parinfer ###
let g:vim_parinfer_filetypes = ["fennel"]

" ### Rainbow ###
let g:rainbow_active = 0

" ### Context ###
let g:context_enabled = 0

" Functions
" ---------
function! LightLineFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? $filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Other
" -----
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|__pycache__\|pyc'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  let g:ag_working_path_mode = 'r'
else
  set grepprg=git\ grep\ --untracked\ --no-color\ -EIne
endif
let g:netrw_keepdir = 0
