call plug#begin('~/.local/share/nvim/plugged')

" Neovim Basics
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer',
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/playground'

" Navigation
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'moberst/telescope.nvim' " Get my custom version to get local commands
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nanotee/zoxide.vim'
Plug 'stevearc/aerial.nvim'
Plug 'vimpostor/vim-tpipeline'
Plug 'anuvyklack/hydra.nvim'
Plug 'ggandor/leap.nvim'
Plug 'folke/todo-comments.nvim'

" Editing
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " UNIX Shell commands
Plug 'milkypostman/vim-togglelist' " <leader>q to toggle quickfix
Plug 'folke/which-key.nvim'
Plug 'lambdalisue/suda.vim' " Sudo Save

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

" Start Screen and rooter
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'

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
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'kdheepak/cmp-latex-symbols'
" Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

call plug#end()

set completeopt=menu,menuone,noselect

set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = " "
set sessionoptions+=globals

" Source for python
let g:python3_host_prog='/home/moberst/.miniconda3/envs/nvim/bin/python3'

if !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
endif

" Setup for neovim remote 
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

map <C-T> :NvimTreeToggle<CR>
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
nnoremap <leader>ft <cmd>TodoTelescope<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fu <cmd>Telescope help_tags<cr>
map <leader>cd :lcd %:h<CR>

autocmd DiagnosticChanged * lua vim.diagnostic.setqflist({open = false })

let g:ale_linters = {'tex': ['chktex']}
let g:ale_linters_explicit = 1  " Only run for the specified linters, no python
" Diffview
nnoremap <silent><leader>gdo :DiffviewOpen<CR>
nnoremap <silent><leader>gdc :DiffviewClose<CR>

" Diagnostics
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Toggle Terminal (see lua for config)
xnoremap <silent> <leader>r :<C-u>ToggleTermSendVisualLines<cr>

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

let python_highlight_all=1
syntax on

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

local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  require("aerial").on_attach(client, bufnr)

end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    server:setup(opts)
end)

require('icon-picker')
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>PickIcons<cr>", opts)
vim.keymap.set("i", "<C-i>", "<cmd>PickInsert<cr>", opts)

require('dap-python').setup('/home/moberst/.miniconda3/envs/nvim/bin/python')
require('dap-python').test_runner = "pytest"
require('nvim-dap-virtual-text').setup({commented = true})
require('dapui').setup()

local dap_breakpoint = {
  error = {
    text = "🛑",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "🌟",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

local dap, dapui = require "dap", require "dapui"
dapui.setup {} -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local opts = { noremap = true, silent = true }

local whichkey = require("which-key")
local keymap = {
  d = {
    name = "Debug",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  },
}

whichkey.register(keymap, {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

-- Unrelated, but setup other stuff 
require('nvim-tree').setup {
  update_cwd = true, 
  respect_buf_cwd = true,
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
    map('n', ']h', "<cmd>Gitsigns next_hunk<CR>")
    map('n', '[h', "<cmd>Gitsigns prev_hunk<CR>")

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
require("catppuccin").setup({
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
      transparent_panel = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    bufferline = true,
    notify = true,
  },
})

require('lualine').setup {
  options = {
    theme = 'catppuccin',
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
require('which-key').setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
})
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
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require('null-ls').setup({
  debug = true,
  on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.formatting_sync()
              end,
          })
      end
  end,
  sources = {
    require('null-ls').builtins.formatting.isort.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/isort',
      extra_args = {'--profile=black'},
    }),
    require('null-ls').builtins.formatting.black.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/black'
    }),
    require('null-ls').builtins.diagnostics.flake8.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/flake8',
      extra_args = {'--config=/home/moberst/.config/flake8'},
    }),
    require('null-ls').builtins.diagnostics.mypy.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/mypy'
    }),
    require('null-ls').builtins.diagnostics.pylint.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/pylint',
      extra_args = {'--rcfile=/home/moberst/.config/pylintrc'},
    }),
    require('null-ls').builtins.diagnostics.gitlint.with({
      command = '/home/moberst/.miniconda3/envs/nvim/bin/gitlint',
      extra_args = {'--config=/home/moberst/.config/gitlint'},
    }),
    require('null-ls').builtins.code_actions.gitsigns,
  }
})

require("neotest").setup({
  adapters = {
    require("neotest-python")
  },
})
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>tt", ":lua require('neotest').summary.toggle()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>tr", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>to", ":lua require('neotest').output.open({enter = true})<CR>", opts)

require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then
      return 20 
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  start_in_insert = true,
  insert_mappings = true, 
  terminal_mappings = true, 
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, 
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("aerial").setup({
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
  end
})

require("diffview").setup()
require("trouble").setup()
require("fidget").setup()
require("colorizer").setup()
require("todo-comments").setup()
require("leap").set_default_keymaps()
require("neogen").setup {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "reST" 
                }
        },
    }
}
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>ds", ":lua require('neogen').generate()<CR>", opts)

local Hydra = require('hydra')


Hydra({
	name = "Resize Window",
	mode = { "n" },
	body = "<C-w>",
	config = {},
	heads = {
		-- resizing window
		{ "<", "<C-w>3<" },
		{ ">", "<C-w>3>" },
		{ "+", "<C-w>2+" },
		{ "-", "<C-w>2-" },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ ";", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})
EOF
