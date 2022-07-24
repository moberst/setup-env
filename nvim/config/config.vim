call plug#begin('~/.local/share/nvim/plugged')

" Neovim Basics
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer',
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Navigation
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'moberst/telescope.nvim' " Get my custom version to get local commands
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'jvgrootveld/telescope-zoxide'
Plug 'nanotee/zoxide.vim'
Plug 'vimpostor/vim-tpipeline'
Plug 'anuvyklack/hydra.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'folke/todo-comments.nvim'

" Editing
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " UNIX Shell commands
Plug 'milkypostman/vim-togglelist' " <leader>q to toggle quickfix
Plug 'lambdalisue/suda.vim' " Sudo Save
Plug 'mbbill/undotree'

" Icons
Plug 'stevearc/dressing.nvim'
Plug 'ziontee113/icon-picker.nvim'

" Snippets
Plug 'SirVer/ultisnips' " Enable the use of snippets
Plug 'moberst/vim-snippets' " My custom snippets

" Linting and testing
Plug 'dense-analysis/ale'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/trouble.nvim'
Plug 'vim-test/vim-test'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'
Plug 'j-hui/fidget.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'

" Display
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'akinsho/toggleterm.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/which-key.nvim'
Plug 'xiyaowong/nvim-transparent'

" Rooter
Plug 'airblade/vim-rooter'
Plug 'rmagatti/auto-session'

" Python
Plug 'danymat/neogen'

" Markdown / Latex
Plug 'lervag/vimtex'
Plug 'dkarter/bullets.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'preservim/vim-markdown'

" Personal management
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'powerman/vim-plugin-AnsiEsc'

" Git integrations
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

" Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Completion with nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-omni'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'onsails/lspkind-nvim'

call plug#end()

let mapleader = " "
set sessionoptions+=globals

" Source for python
let g:python3_host_prog='/home/moberst/.miniconda3/envs/nvim/bin/python3'

" Setup for neovim remote 
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

nnoremap <F5> :UndotreeToggle<CR>
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

map <C-T> :NvimTreeToggle<CR>
let g:rooter_patterns = ['.git', 'index.wiki']

let g:ale_linters = {'tex': ['chktex']}
let g:ale_linters_explicit = 1  " Only run for the specified linters, no python
" Diffview
nnoremap <silent><leader>gdo :DiffviewOpen<CR>
nnoremap <silent><leader>gdc :DiffviewClose<CR>

" Diagnostics
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Setup for snippets
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit="vertical" 
let g:ultisnips_python_quoting_style = "single"
let g:ultisnips_python_triple_quoting_style = "double"
let g:ultisnips_python_style = "google"

" Quickfix mapping
let g:toggle_list_no_mappings = v:false

" No fancy cursor nonsense, we do it old school
set guicursor=

if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
colorscheme catppuccin

" let g:tokyonight_style = "storm"
" colorscheme tokyonight

" Sweet search options!
set incsearch
set hlsearch

set number
set encoding=utf-8
set colorcolumn=81
set tags=tags

set updatetime=100

" Alias some stupid bugs
:command W w
:command Xa xa

set wrap linebreak nolist breakindent

" Set indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Setup for vimtex
let g:vimtex_fold_enabled = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_toc_enabled = 1
let g:vimtex_quickfix_mode = 0 
let g:vimtex_toc_config = {
      \ 'mode' : 1,
      \ 'layers' : [ 'content' ],
      \ 'tocdepth' : 2,
      \}

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

nmap <leader>ll :VimtexCompile<CR>
nmap <leader>lv :VimtexView<CR>
nmap <leader>lt :VimtexTocToggle<CR>

" Setup for vimwiki/vimwiki
let g:vimwiki_list = [{
  \ 'name': 'Research', 'path': '~/Dropbox/research/wiki/', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1},
  \ {'name': 'Reflection', 'path': '~/log/wiki', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}, 
  \ {'name': 'Health', 'path': '~/Dropbox/org/health/wiki', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}, 
  \ {'name': 'D&D', 'path': '~/Dropbox/dnd/wiki', 'syntax': 'default', 'ext': '.wiki', 'links_space_char': '-', 'auto_tags': 1}]
let g:vimwiki_global_ext = 0
let g:vimwiki_auto_chdir = 1
let g:vimwiki_folding = 'expr'
nmap <leader>wt :VimwikiGenerateTagLinks 

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
let g:vim_markdown_math = 1
let g:markdown_folding = 1

" Use spaces instead of tabs, and keep the whitespace small
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set backspace=2 " make backspace work like most other apps

" Switch between splits using ctr+j/k/l/h
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Get rid of <C-A> for increment, easy mistake when using this as tmux prefix
nnoremap <C-A> <C-W>

" Keep visual mode after indent
vnoremap > >gv
vnoremap < <gv

" Clear all buffers except the current one
command! BufOnly execute '%bdelete|edit #|normal `"'
nnoremap <leader>ca :BufOnly<cr>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the ,
nnoremap , za

" Latex setup
au BufNewFile,BufRead *.tex
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add |
    \ let maplocalleader="\\" |
    \ set colorcolumn=0

" Trouble toggle quickfix
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" Override default VIM (see /usr/share/nvim/runtime/ftplugin/python.vim) by
" setting this to zero.  Otherwise, this enforces:
" setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
let g:python_recommended_style=1

" markdown setup
au BufNewFile,BufRead *.md
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/md/en.utf-8.add |
    \ set colorcolumn=0

au BufNewFile,BufRead *.wiki
    \ set spell | 
    \ set spellfile=$HOME/Dropbox/org/md/en.utf-8.add |
    \ set colorcolumn=0

" python setup
au BufNewFile,BufRead *.py
    \ setlocal textwidth=88 |
    \ setlocal colorcolumn=89 |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

au TermOpen * setlocal nospell

let python_highlight_all=1
syntax on

nnoremap <leader>ja <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>jt <cmd>Telescope harpoon marks<cr>
nnoremap <leader>jn <cmd>lua require("harpoon.ui").nav_next()<cr>
nnoremap <leader>jp <cmd>lua require("harpoon.ui").nav_prev()<cr>

lua << EOF
require("config")
EOF
