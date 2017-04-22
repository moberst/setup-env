#!/bin/bash

# Install git
sudo apt-get install git-all

# Set up git configuations
git config --global user.name "Michael Oberst"
git config --global user.email michael.k.oberst@gmail.com
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global core.editor vim
git config --global push.default simple
