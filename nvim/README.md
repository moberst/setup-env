# Plugins

Some documentation for each plugin that I have, and why they are useful!

Note that I have re-defined leader to ","

## Navigation
```
Plug 'scrooloose/nerdtree'
Plug 'nvim-telescope/telescope.nvim'
```

* `<C-T>` to see a local filetree
* `<leader>ff` to search for files
* `<leader>fg` to search for git files
* `<leader>fb` to search buffers
* `<leader>fs` to search for a string (live grep)
* `<leader>ft` for a file tree

## Editing 
```
Plug 'tomtom/tcomment_vim' 
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " UNIX Shell commands
```

* `gc` to toggle comments in visual mode!
* Change arbitrary surrounding delimiters, like `cs"`, or add quotes around a word with `ysiw"`
* Repeat other vim commands with `.`
* Various QoL pairs, like `[<space>` to add a line 
* Commands like `:Rename` to rename a file 

```
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
```
Get multiple cursors, select a word and just use `<C-N>`

```
Plug 'milkypostman/vim-togglelist'
```
`<leader>q` to toggle the quickfix list

## Snippets
```
Plug 'SirVer/ultisnips' " Enable the use of snippets
Plug 'moberst/vim-snippets' " My custom snippets
```
Self explanatory, but see autocomplete below for precise instructions.

## Linting and testing
```
Plug 'vim-scripts/taglist.vim'
Plug 'dense-analysis/ale'
Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
```
Use `]t` to go to the tag for a function!  ALE will mostly just work in the background, and should fix files on save, but you can also use 
* `<leader>ad` to go to definition in a vsplit (Ale Definition)
* `<leader>ar` to find refererences (Ale Reference)

For testing, you can do (in a test file)
* `<leader>tt` toggle the test window
* `<leader>tr` run the tests

## Python
```
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
```
* `<leader>ds` to create a docstring when on a def line.

## Markdown / Latex
```
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
```

## Git integrations
```
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
```
* All the wonderful git commands like `:Gpush`
* Cool signs, but also `]h` to move between hunks, and 
* `<leader>hs` to stage, or `<leader>hu` to undo a hunk, or `<leader>hp` to preview

# Theme
```
Plug 'rafi/awesome-vim-colorschemes'
```

# Neovim 0.5 features
```
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
```
