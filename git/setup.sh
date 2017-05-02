#!/bin/bash

# Install git
sudo apt-get install git-all

# Set up git configuations
# Alternatively, use the my_gitconfig file, and copy to 
# $HOME/.git/.gitconfig
git config --global user.name "Michael Oberst"
git config --global user.email michael.k.oberst@gmail.com
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global core.editor vim
git config --global push.default simple
git config --global credential.helper cache
