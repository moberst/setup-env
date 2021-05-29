call plug#begin('~/.local/share/nvim/plugged')

" File searching, requires ripgrep
Plug 'scrooloose/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Editing
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'kshenoy/vim-signature' " Display marks
Plug 'easymotion/vim-easymotion' " leader/leader then jump
Plug 'vim-scripts/taglist.vim'
Plug 'tmhedberg/SimpylFold'

" Snippets
Plug 'SirVer/ultisnips' " Enable the use of snippets
Plug 'moberst/vim-snippets' " My custom snippets
Plug 'ervandew/supertab'

" Linting
Plug 'dense-analysis/ale'

" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Latex
Plug 'lervag/vimtex'

" Git integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Theme
Plug 'jnurmine/Zenburn'
Plug 'rafi/awesome-vim-colorschemes'

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required

if exists('g:gui_oni')
  set number
  set noswapfile
  set smartcase

  " Enable GUI mouse behavior
  set mouse=a

  " If using Oni's externalized statusline, hide vim's native statusline, 
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endif

" Nvim specific setup

" Source for python
let g:python3_host_prog='/home/moberst/.miniconda3-fresh/bin/python3'

" Setup for ALE
let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'mypy', 'pylint'], 'tex': ['chktex']}
let g:ale_fixers = {'python': ['yapf']}
let g:ale_python_flake8_executable='/home/moberst/.miniconda3-fresh/bin/flake8'
let g:ale_python_pydocstyle_executable='/home/moberst/.miniconda3-fresh/bin/pydocstyle'
let g:ale_python_mypy_executable='/home/moberst/.miniconda3-fresh/bin/mypy'
let g:ale_python_yapf_executable='/home/moberst/.miniconda3-fresh/bin/yapf'
let g:ale_python_pylint_executable='/home/moberst/.miniconda3-fresh/bin/pylint'

" Setup for pydocstring
let g:pydocstring_formatter='google'

" No fancy cursor nonsense, we do it old school
set guicursor=

"" Old VIM setup, but cut down due to redundant plugins

" GENERAL setup
" colorscheme zenburn
colorscheme sonokai

" Sweet search options!
set incsearch
set hlsearch

set number
set encoding=utf-8
set colorcolumn=81
set tags=tags

" Tag list toggle
nnoremap <silent> <F8> :TlistToggle<CR>

" Alias some stupid bugs
:command W w
:command Xa xa

if $TERM == 'screen'
  set t_Co=256
endif

set wrap linebreak nolist 

" Set indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Setup for snippets
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit="vertical" 

" Setup for vimtex
let g:vimtex_fold_enabled = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_toc_enabled = 1

let g:vimtex_compiler_method='latexmk'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : './tex',
        \ 'options' : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

" Setup for plasticboy/vim-markdown
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1

" Setup for JamshedVesuna/vim-markdown-preview
" Map markdown preview to CTRL-M
let vim_markdown_preview_hotkey='<C-M>'
" Display images
let vim_markdown_preview_toggle=1
" Use grip for markdown preview
let vim_markdown_preview_github=1
" Remove temp file after loading in browser
let vim_markdown_preview_temp_file=1

" Use spaces instead of tabs, and keep the whitespace small
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set backspace=2 " make backspace work like most other apps

" Switch between splits using ctr+j/k/l/h
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Keep visual mode after indent
vnoremap > >gv
vnoremap < <gv

" Mappings for CtrlSF
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" NERDtree settings
" Toggle Nerdtree with C-T
map <C-T> :NERDTreeToggle<CR>
" Close Vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Latex setup
au BufNewFile,BufRead *.tex
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add

" python setup
au BufNewFile,BufRead *.py
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

let python_highlight_all=1
syntax on

" Copyright 2019 Google LLC
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"    https://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
