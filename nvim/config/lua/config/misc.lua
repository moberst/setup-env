require("zk").setup()

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

require'plenary.filetype'.add_file('wiki')

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

require("papis").setup({
  -- These are configuration options of the `papis` program relevant to papis.nvim.
  -- Papis.nvim can get them automatically from papis, but this is very slow. It is
  -- recommended to copy the relevant settings from your papis configuration file.
  papis_python = {
    dir = "/home/moberst/Dropbox/papis",
    info_name = "info.yaml", -- (when setting papis options `-` is replaced with `_`
                             -- in the keys names)
  },
  init_filenames = { "%info_name%", "*.wiki", "*.tex", "*.md", "*.norg" },
  -- Enable the default keymaps
  enable_keymaps = true,
  enable_fs_watcher = true,
  -- For tables, the first is inserting, and the second is to search refs
  cite_formats = {
    tex = { "\\citep{%s}", "\\cite[tp]?%*?{%s}" },
    markdown = "@%s",
    vimwiki = "@%s",
    rmd = "@%s",
    plain = "%s",
    org = { "[cite:@%s]", "%[cite:@%s]" },
    norg = "{= %s}",
  },
})

require("nvim-possession").setup({
  autoswitch = {
    enable = true 
  }
})
