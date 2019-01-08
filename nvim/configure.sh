#!/bin/sh

cp init.vim ~/.config/nvim/init.vim
if [ ! -f /usr/share/nvim/runtime/autoload/plug.vim ]; then
  sudo cp plug.vim /usr/share/nvim/runtime/autoload/plug.vim
fi
