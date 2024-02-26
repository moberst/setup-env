require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
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

-- Set up filetypes 
cmp.setup.filetype('vimwiki', {
  sources = cmp.config.sources({
    { name = 'ultisnips' },
  }, {
    { name = 'omni' },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('yaml', {
  sources = cmp.config.sources({
    { name = 'papis' },
  })
})

-- Autopairs
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
