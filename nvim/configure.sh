#!/bin/sh

cd ./config
cp init.vim config.vim google.vim ~/.config/nvim/

RUNTIME_PATH=$HOME/.neovim/share/nvim/runtime

if [ ! -f $RUNTIME_PATH/autoload/plug.vim ]; then 
  sudo cp plug.vim $RUNTIME_PATH/autoload/plug.vim
fi
