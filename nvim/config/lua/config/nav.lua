require('auto-session').setup({
      log_level = 'info',
      auto_session_suppress_dirs = {'~/'}
    })

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
  extensions = {
    file_browser = {
      hijack_netrw = true,
    }
  },
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
require("telescope").load_extension("file_browser")
require("telescope").load_extension('harpoon')
require('telescope').load_extension('media_files')
require('telescope').load_extension('zoxide')

require("leap").set_default_keymaps()
require('icon-picker')
