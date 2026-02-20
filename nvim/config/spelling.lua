vim.cmd([[
au BufNewFile,BufRead *.tex
    \ set spell |
    \ set spellfile=$HOME/Dropbox/org/tex/en.utf-8.add |
    \ set colorcolumn=0
]])

vim.cmd([[
au BufNewFile,BufRead *.md
    \ set spell |
    \ set spellfile=$HOME/Dropbox/org/md/en.utf-8.add |
]])
