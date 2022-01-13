#!/bin/bash

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
git config --global pull.rebase false

# Only run these once diff-so-fancy is installed
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
