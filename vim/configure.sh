#!/bin/bash

# setup .vimrc
cp my_vimrc ~/.vimrc

# Reinstall plugins
vim +PluginInstall +qall
