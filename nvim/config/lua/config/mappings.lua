local wk = require("which-key")

-- " Find files using telescope

wk.register({
  ["<leader><leader>"] = {
    name = "+insert",
    i = { "<cmd>PickIcons<cr>", "[i]cons" },
  },
  ["<leader>f"] = {
    name = "+[f]ind",
    f = { "<cmd>Telescope find_files<cr>", "[f]ile search" },
    e = { "<cmd>Telescope session-lens search_session<cr>", "s[e]ssion" },
    x = { "<cmd>Telescope file_browser<cr>", "[x] file browser" },
    b = { "<cmd>Telescope buffers<cr>", "[b]uffers" },
    s = { "<cmd>Telescope live_grep<cr>", "global [s]tring" },
    l = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[l]ocal string" },
    d = { "<cmd>Telescope lsp_workspace_symbols<cr>", "[d]efinitions" },
    r = { "<cmd>Telescope lsp_references<cr>", "[r]eferences (under cursor)" },
    i = { "<cmd>Telescope diagnostics<cr>", "d[i]agnostics" },
    t = { "<cmd>Telescope tags<cr>", "[t]ags" },
    w = { "<cmd>cd $HOME/Dropbox/research/wiki<cr><cmd>lua require'telescope.builtin'.tags({ctags_file='$HOME/Dropbox/research/wiki/.vimwiki_tags'})<cr>", "[w]iki tags" },
    c = { "<cmd>Telescope commands<cr>", "[c]ommands" },
    m = { "<cmd>Telescope media_files<cr>", "[m]edia files" },
    h = { "<cmd>Telescope help_tags<cr>", "[h]elp" },
    o = { "<cmd>TodoTelescope<cr>", "t[o]do" },
    z = {	"<cmd>lua require'telescope'.extensions.zoxide.list{}<CR>", "[z]oxide"}
  },
  ["<leader>r"] = {
    name = "+[r]un tests",
    r = { ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "[r]un tests"},
    v = { ":lua require('neotest').output.open({enter = true})<CR>", "[v]iew output"},
    s = { ":lua require('neotest').summary.toggle()<CR>", "[s]ummary" },
  },
  ["<leader>d"] = {
    name = "+[d]ebug",
    s = { "<cmd>lua require'dap'.continue()<cr>", "[s]tart/continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "step [i]nto" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "step o[u]t" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "step [o]ver" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "step [b]ack" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "toggle [U]I" },
    q = { "<cmd>lua require'dap'.close()<cr>", "[q]uit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "toggle [r]epl" },
    m = { "<cmd>lua require'dap-python'.test_method()<cr>", "test [m]ethod" },
    c = { "<cmd>lua require'dap-python'.test_class()<cr>", "test [c]lass" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "[t]oggle breakpoint" },
  },
  ["<leader>t"] = {
    name = "+[t]oggle",
    b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "[b]lame" },
    d = { "<cmd>Gitsigns toggle_deleted<cr>", "[d]eleted" },
    l = { "<cmd>ToggleLSPLines<cr>", "[l]ine diagnostics" },
  },
  ["<leader>b"] = {
    name = "+[b]ufferline",
    o = { "<cmd>BufferLinePick<cr>", "[o]pen (pick)" },
    c = { "<cmd>BufferLinePickClose<cr>", "[c]lose (pick)" },
    h = { "<cmd>BufferLineMovePrev<cr>", "move (left)" },
    l = { "<cmd>BufferLineMoveNext<cr>", "move (right)" },
  },
  ["<leader>q"] = { "<cmd>call ToggleQuickfixList()<CR>", "[q]flist toggle"},
  ["["] = {
    name = "+previous",
    b = { "<cmd>BufferLineCyclePrev<cr>", "[b]uffer" },
    d = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[d]iagnostic" },
    h = { "<cmd>Gitsigns prev_hunk<cr>", "[h]unk" },
  },
  ["]"] = {
    name = "+next",
    b = { "<cmd>BufferLineCycleNext<cr>", "[b]uffer" },
    d = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[d]iagnostic" },
    h = { "<cmd>Gitsigns next_hunk<cr>", "[h]unk" },
  },
})

wk.register({
  ["<leader>z"] = {
    name = "+[z]en mode",
    n = { "<cmd>TZNarrow<cr>", "[n]arrow" },
    f = { "<cmd>TZFocus<cr>", "[f]ocus" },
    m = { "<cmd>TZMinimalist<cr>", "[m]inimalist" },
    a = { "<cmd>TZAtaraxis<cr>", "[a]taraxis" },
  },
}, {mode = 'n'})

wk.register({
  ["<leader>z"] = {
    name = "+[z]en mode",
    n = { "<cmd>TZNarrow<cr>", "[n]arrow" },
  },
}, {mode = 'v'})
