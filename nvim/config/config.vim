call plug#begin('~/.local/share/nvim/plugged')

" Navigation
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'moberst/telescope.nvim' " Get my custom version to get local commands
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nanotee/zoxide.vim'

" Editing
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " UNIX Shell commands
Plug 'milkypostman/vim-togglelist' " <leader>q to toggle quickfix
Plug 'folke/which-key.nvim'
Plug 'lambdalisue/suda.vim' " Sudo Save

" Snippets
Plug 'SirVer/ultisnips' " Enable the use of snippets
Plug 'moberst/vim-snippets' " My custom snippets

" Linting and testing
Plug 'dense-analysis/ale'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }

" Display
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'kevinhwang91/nvim-bqf'

" Start Screen and rooter
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'

" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Markdown / Latex
Plug 'lervag/vimtex'
Plug 'dkarter/bullets.vim'

" Personal management
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'powerman/vim-plugin-AnsiEsc'

" Git integrations
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

" Theme
" Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'

" Neovim 0.5 features
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer',
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/playground'

" Completion with nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'kdheepak/cmp-latex-symbols'
" Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

" Jupyter Support
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set completeopt=menu,menuone,noselect

set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = " "
set sessionoptions+=globals

" Source for python
let g:python3_host_prog='/home/moberst/.miniconda3/envs/nvim/bin/python3'

" Setup for neovim remote 
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

map <C-T> :NvimTreeToggle<CR>
let g:nvim_tree_respect_buf_cwd = 1
let g:startify_custom_header = startify#center([
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\ '          Focus on the process, not the outcome        ',
\])
let g:startify_session_delete_buffers = 1
" let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_session_savevars = []
let g:rooter_patterns = ['.git', 'index.wiki']

" Buffer Setup, this overwrites e.g., vim-unimpaired [b which does :bprevious
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent><leader>bp :BufferLinePick<CR>
nnoremap <silent><leader>bf :BufferLinePick<CR>
nnoremap <silent><leader>bc :BufferLinePickClose<CR>
nnoremap <silent><leader>bd :BufferLinePickClose<CR>
nnoremap <silent><leader>[b :BufferLineMovePrev<CR>
nnoremap <silent><leader>]b :BufferLineMoveNext<CR>

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

let g:startify_bookmarks = [ 
      \ {'t': '~/Dropbox/thesis'},  
      \ {'c': '~/repos/setup-env/nvim/config/config.vim' },
      \ ]

" Find files using telescope
"nnoremap <leader>ff <cmd>Telescope find_files theme=get_dropdown<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fu <cmd>Telescope help_tags<cr>
map <leader>cd :lcd %:h<CR>

" Setup for ALE
let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'mypy', 'pylint'], 'tex': ['chktex']}
let g:ale_fixers = {'python': ['yapf']}
let g:ale_python_flake8_executable='/home/moberst/.miniconda3/envs/nvim/bin/flake8'
let g:ale_python_pydocstyle_executable='/home/moberst/.miniconda3/envs/nvim/bin/pydocstyle'
let g:ale_python_mypy_executable='/home/moberst/.miniconda3/envs/nvim/bin/mypy'
let g:ale_python_yapf_executable='/home/moberst/.miniconda3/envs/nvim/bin/yapf'
let g:ale_python_pylint_executable='/home/moberst/.miniconda3/envs/nvim/bin/pylint'

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Diffview
nnoremap <silent><leader>do :DiffviewOpen<CR>
nnoremap <silent><leader>dc :DiffviewClose<CR>

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

colorscheme tokyonight

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
let g:vimtex_quickfix_mode = 0 " Do not open the quickfix window, use Trouble 
let g:vimtex_toc_config = {
      \ 'mode' : 1,
      \ 'layers' : [ 'content' ],
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
" let g:vim_markdown_math = 1
" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_toc_autofit = 1
let g:markdown_folding = 1

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
    \ setlocal textwidth=79 |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

let python_highlight_all=1
syntax on

" Magma setup
nnoremap <silent> <Leader>ri :MagmaInit<CR>
" nnoremap <silent><expr> <Leader>r  :MagmaEvaluateOperator<CR>
" nnoremap <silent>       <Leader>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <Leader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <Leader>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <Leader>rd :MagmaDelete<CR>
nnoremap <silent>       <Leader>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false

" Taken from https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, 
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), 
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, 
    { name = "latex_symbols" },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = false, 
      maxwidth = 50, 
    })
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lsp
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  -- require "lsp_signature".on_attach()

end

local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    server:setup(opts)
end)

-- Turn off mostly useless type checking diagnostics
vim.diagnostic.config({
  -- virtual_text = false,
})

-- Unrelated, but setup other stuff 
require('nvim-tree').setup {
  update_cwd = true, 
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "<C-t>", cb = ":NvimTreeToggle<cr>", mode = "n"},
      },
    },
  }
}

require("telescope").setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}

require('gitsigns').setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
require('bufferline').setup {
  offsets = {
    {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    }
  },
}
require('lualine').setup {
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {"%{fnamemodify(v:this_session,':t')}"},
    lualine_x = {'filename'},
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'location'}
  },
}
require('which-key').setup()
require('treesitter-context').setup()
require('nvim-treesitter.configs').setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
require("diffview").setup()
EOF
