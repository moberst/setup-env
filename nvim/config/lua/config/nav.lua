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
require('telescope').load_extension('media_files')
require('telescope').load_extension('zoxide')

require("leap").set_default_keymaps()
require('icon-picker')
