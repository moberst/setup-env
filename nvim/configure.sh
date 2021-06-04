#!/bin/sh

cp init.vim stable.vim nightly.vim ~/.config/nvim/

if [ ! -f /usr/share/nvim/runtime/autoload/plug.vim ]; then
  sudo cp plug.vim /usr/share/nvim/runtime/autoload/plug.vim
fi
