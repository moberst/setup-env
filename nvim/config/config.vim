call plug#begin('~/.local/share/nvim/plugged')

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Editing
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " UNIX Shell commands
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'milkypostman/vim-togglelist' " <leader>q to toggle quickfix

" Snippets
Plug 'SirVer/ultisnips' " Enable the use of snippets
Plug 'moberst/vim-snippets' " My custom snippets

" Linting and testing
Plug 'vim-scripts/taglist.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

" Notifications
Plug 'rcarriga/nvim-notify'

" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Markdown / Latex
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

" Personal management
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'powerman/vim-plugin-AnsiEsc'

" Git integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Theme
" Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'

" Neovim 0.5 features
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Completion with nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'ray-x/lsp_signature.nvim'

" Jupyter Support
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set completeopt=menu,menuone,noselect

set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","

" Source for python
let g:python3_host_prog='/home/moberst/.miniconda3-fresh/envs/nvim/bin/python3'

" NERDtree settings
" Toggle Nerdtree with C-T
map <C-T> :NERDTreeToggle<CR>
" Close Vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Find files using telescope
nnoremap <leader>ff <cmd>Telescope find_files theme=get_dropdown<cr>
nnoremap <leader>fg <cmd>Telescope git_files theme=get_dropdown<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=get_dropdown<cr>
nnoremap <leader>fs <cmd>Telescope live_grep theme=get_dropdown<cr>
nnoremap <leader>ft <cmd>Telescope file_browser theme=get_dropdown<cr>

" Setup for ALE
let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'mypy', 'pylint'], 'tex': ['chktex']}
let g:ale_fixers = {'python': ['yapf']}
let g:ale_python_flake8_executable='/home/moberst/.miniconda3-fresh/bin/flake8'
let g:ale_python_pydocstyle_executable='/home/moberst/.miniconda3-fresh/bin/pydocstyle'
let g:ale_python_mypy_executable='/home/moberst/.miniconda3-fresh/bin/mypy'
let g:ale_python_yapf_executable='/home/moberst/.miniconda3-fresh/bin/yapf'
let g:ale_python_pylint_executable='/home/moberst/.miniconda3-fresh/bin/pylint'

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
nmap <leader>ad <Plug>(ale_go_to_definition_in_vsplit)
nmap <leader>ar <Plug>(ale_find_references)

" Tag list toggle
nnoremap <silent> <F8> :TlistToggle<CR>
let g:gutentags_ctags_tagfile = '.git/tags'

" Setup for pydocstring
let g:pydocstring_formatter='google'
nmap <leader>ds :Pydocstring<CR>

" Setup for vim-test
let test#strategy = 'neovim'
nmap <leader>tt <Plug>(ultest-summary-toggle)
nmap <leader>tr <Plug>(ultest-run-file)

" Setup for snippets
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit="vertical" 
let g:ultisnips_python_quoting_style = "single"
let g:ultisnips_python_triple_quoting_style = "double"
let g:ultisnips_python_style = "google"

" GitGutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
 
" Quickfix mapping
let g:toggle_list_no_mappings = v:false
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" No fancy cursor nonsense, we do it old school
set guicursor=

if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

colorscheme solarized8_flat

" Sweet search options!
set incsearch
set hlsearch
nmap <silent><leader>h :noh<CR>

set number
set encoding=utf-8
set colorcolumn=81
set tags=tags

set updatetime=100

" Alias some stupid bugs
:command W w
:command Xa xa

set wrap linebreak nolist 

" Set indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

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

" Setup for vimwiki/vimwiki
let g:vimwiki_list = [{'name': 'Research', 'path': '~/Dropbox/research/wiki/', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}, {'name': 'Reflection', 'path': '~/log/wiki', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}, {'name': 'D&D', 'path': '~/Dropbox/dnd/wiki', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}]
let g:vimwiki_global_ext = 0

" Copied from documentation, want to let vimwiki open text files in a new tab
function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'edit ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction


" Setup for plasticboy/vim-markdown
set conceallevel=2
" let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1

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

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" Latex setup
au BufNewFile,BufRead *.tex
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add |
    \ let maplocalleader="\\"

nmap <leader>ll :VimtexCompile<CR>
nmap <leader>lv :VimtexView<CR>


" Override default VIM (see /usr/share/nvim/runtime/ftplugin/python.vim) by
" setting this to zero.  Otherwise, this enforces:
" setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
let g:python_recommended_style=1

" markdown setup
au BufNewFile,BufRead *.md
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/md/en.utf-8.add

" python setup
au BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set autoindent |
    \ set fileformat=unix

let python_highlight_all=1
syntax on

" Magma setup
nnoremap <silent> <Leader>ri :MagmaInit<CR>
nnoremap <silent><expr> <Leader>r  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <Leader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <Leader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <Leader>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <Leader>rd :MagmaDelete<CR>
nnoremap <silent>       <Leader>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false

" Taken from https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup {
  capabilities = capabilities,
  require "lsp_signature".on_attach()
}

-- Unreleated, but set up Notifications
vim.notify = require("notify")
EOF
