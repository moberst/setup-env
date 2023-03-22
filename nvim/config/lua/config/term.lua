require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  start_in_insert = false,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  on_open = function(term)
    set_terminal_keymaps()
  end, -- function to run when the terminal opens
  close_on_exit = true,
  shade_terminals = true,
}

-- Only used for generic terminals, not lazygit
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

require("flatten").setup({
  window = {
    open = "current"
  },
  callbacks = {
    pre_open = function()
      -- Close toggleterm when an external open request is received
      require("toggleterm").toggle(0)
    end,
    post_open = function(bufnr, winnr, ft)
      if ft == "gitcommit" then
        -- If the file is a git commit, create one-shot autocmd to delete it on write
        -- If you just want the toggleable terminal integration, ignore this bit and only use the
        -- code in the else block
        vim.api.nvim_create_autocmd(
          "BufWritePost",
          {
            buffer = bufnr,
            once = true,
            callback = function()
              -- This is a bit of a hack, but if you run bufdelete immediately 
              -- the shell can occasionally freeze
              vim.defer_fn(
                  function()
                      vim.api.nvim_buf_delete(bufnr, {})
                  end,
                  50
              )
            end
          }
        )
      else
        -- If it's a normal file, then reopen the terminal, then switch back to the newly opened window
        -- This gives the appearance of the window opening independently of the terminal
        require("toggleterm").toggle(0)
        vim.api.nvim_set_current_win(winnr)
      end
    end,
    block_end = function()
      -- After blocking ends (for a git commit, etc), reopen the terminal
      require("toggleterm").toggle(0)
    end
  }
  })

