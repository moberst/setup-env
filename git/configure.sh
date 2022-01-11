#!/bin/bash

# Set up ctags template (for Vim)
git config --global init.templatedir '~/.git_template'
mkdir -p ~/.git_template
if [ -d ~/.git_template/hooks ]; then
    rm ~/.git_template/hooks -rf
fi
cp hooks/ ~/.git_template/hooks -r
git config --global alias.ctags '!.git/hooks/ctags'

# Set up git configuations
git config --global user.name "Michael Oberst"
git config --global user.email michael.k.oberst@gmail.com
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global core.editor nvim
git config --global push.default simple
git config --global credential.helper cache
git config --global Core.fileMode false
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

cat gitconfig >> $HOME/.gitconfig
