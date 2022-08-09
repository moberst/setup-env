function _G.close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

require('auto-session').setup({
      log_level = 'info',
      auto_session_suppress_dirs = {'~/', '~/Dropbox/research/wiki'},
      pre_save_cmds = { _G.close_all_floating_wins },
    })

require('session-lens').setup()
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals"

require("telescope").setup {
  defaults = {
    tiebreak = function ()
      return true
    end,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      hijack_netrw = true,
    }
  },
  pickers = {
    tags = {
      only_sort_tags = true,
      fname_width = 50,
      -- sorting_strategy = 'ascending',
    },
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
require('telescope').load_extension('fzf')
require("telescope").load_extension("file_browser")
require("telescope").load_extension('harpoon')
require('telescope').load_extension('media_files')
require('telescope').load_extension('zoxide')
require('telescope').load_extension('session-lens')

require("leap").set_default_keymaps()
require('icon-picker')
