#!/bin/bash

# setup .vimrc
cp vimrc ~/.vimrc

# Reinstall plugins
vim +PluginInstall +qall
