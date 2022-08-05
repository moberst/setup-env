require('auto-session').setup({
      log_level = 'info',
      auto_session_suppress_dirs = {'~/'}
    })

require('session-lens').setup()
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals"

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
require('telescope').load_extension('session-lens')

require("leap").set_default_keymaps()
require('icon-picker')
