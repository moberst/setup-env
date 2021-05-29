#!/bin/sh

# Version that includes nvim.coc
cat init_coc.vim google.vim coc.vim > ~/.config/nvim/init.vim
cp coc-settings.json ~/.config/nvim/coc-settings.json

# Basic version without nvim.coc
# cp init.vim ~/.config/nvim/init.vim

if [ ! -f /usr/share/nvim/runtime/autoload/plug.vim ]; then
  sudo cp plug.vim /usr/share/nvim/runtime/autoload/plug.vim
fi
