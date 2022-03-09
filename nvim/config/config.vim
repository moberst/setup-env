call plug#begin('~/.local/share/nvim/plugged')

" NVIM Tree with Icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Telescope fuzzy finder
Plug 'moberst/telescope.nvim' " Get my custom version to get local commands
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'folke/which-key.nvim'

" Display
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

" Git markers
Plug 'lewis6991/gitsigns.nvim'

" Colorscheme 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'

" Core Neovim features: Language Server Support and other stuff 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer',
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Completion with nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

call plug#end()

set completeopt=menu,menuone,noselect

set nocompatible              " be iMproved, required
filetype off                  " required
set guicursor=

" leader: Mine is set to spacebar
let mapleader = " "

" Colorscheme
colorscheme tokyonight

" Some display options
set wrap linebreak nolist breakindent incsearch hlsearch number 

set encoding=utf-8
set colorcolumn=81
set updatetime=100
set conceallevel=2
set foldmethod=indent
set foldlevel=99

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

" TODO: Fill in these paths, these are examples from my personal computer
let g:python3_host_prog='/home/moberst/.miniconda3/envs/nvim/bin/python3'

" File Navigation
map <C-T> :NvimTreeToggle<CR>

" Move around and select buffers.  Note that my leader key is space.
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent><leader>bp :BufferLinePick<CR>
nnoremap <silent><leader>bf :BufferLinePick<CR>
nnoremap <silent><leader>bc :BufferLinePickClose<CR>
nnoremap <silent><leader>bd :BufferLinePickClose<CR>
nnoremap <silent><leader>[b :BufferLineMovePrev<CR>
nnoremap <silent><leader>]b :BufferLineMoveNext<CR>

" Find files using telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fu <cmd>Telescope help_tags<cr>

" Set indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Override default VIM (see /usr/share/nvim/runtime/ftplugin/python.vim) by
" setting this to zero.  Otherwise, this enforces:
" setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
let g:python_recommended_style=1

" python setup
au BufNewFile,BufRead *.py
    \ setlocal textwidth=79 |
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
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), 
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
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

  require "lsp_signature".on_attach()

end

local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    server:setup(opts)
end)

-- Setup Tree
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

-- Add ability to delete buffers in telescope
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
EOF
