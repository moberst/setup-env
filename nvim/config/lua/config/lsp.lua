require("mason").setup()

local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

end

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.jedi_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.r_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.texlab.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

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
    -- This throws too many errors with null-ls
    -- require('null-ls').builtins.diagnostics.chktex,
  }
})

require('treesitter-context').setup()
require('nvim-treesitter.configs').setup({
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
})

require("lsp_lines").setup()
-- Off by default, but the command below will toggle between the two
vim.diagnostic.config({ virtual_lines = false })
-- Define command for toggling lsp_lines versus normal mode
vim.api.nvim_create_user_command(
  'ToggleLSPLines',
  function(opts)
    local new_text = not vim.diagnostic.config().virtual_text
    local new_lines = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_lines})
    vim.diagnostic.config({ virtual_text = new_text })
  end,
  {}
)
